module Friendable
  extend ActiveSupport::Concern

  included do
    has_many :friendships, dependent: :destroy
    has_many :friends, -> { Friendship.accepted }, through: :friendships
    has_many :pending_friends, -> { Friendship.pending }, through: :friendships, source: :friend
    has_many :requested_friends, -> { Friendship.requested }, through: :friendships, source: :friend
    has_many :declined_friends, -> { Friendship.declined }, through: :friendships, source: :friend

    include InstanceMethods
  end

  module InstanceMethods
    def send_friend_request(friend)
      friendships.find_or_create_by(friend: friend, status: :pending)
      Friendship.find_or_create_by(user: friend, friend: self, status: :requested)
    end

    def accept_friend_request(friend)
      friendship = friendships.find_by(friend: friend, status: :requested)
      friendship.accepted!
      Friendship.find_by(user: friend, friend: self, status: :pending).accepted!
    end

    def decline_friend_request(friend)
      friendship = friendships.find_by(friend: friend, status: :requested)
      friendship.declined!
      Friendship.find_by(user: friend, friend: self, status: :pending).declined!
    end

    def unfriend(friend)
      friendships.accepted.find_by(friend: friend).destroy
      friend.friendships.accepted.find_by(friend: self).destroy
    end

    def friend?(user)
      friendships.where(friend_id: user, status: 'accepted').any?
    end

    def pending_friend?(user)
      friendships.where(friend_id: user, status: 'pending').any?
    end

    def request_friend?(user)
      friendships.where(friend_id: user, status: 'requested').any?
    end
  end
end

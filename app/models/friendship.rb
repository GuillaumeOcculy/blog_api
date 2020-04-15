class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates :user_id, :friend_id, :status, presence: true

  enum status: %i[pending requested accepted declined]
end

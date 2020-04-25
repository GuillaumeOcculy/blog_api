class Conversation < ApplicationRecord
  has_many :conversation_users, dependent: :destroy
  has_many :users, through: :conversation_users
  has_many :messages, dependent: :destroy

  validates :name, presence: true

  def self.find_by_users(users)
    usernames = users.pluck(:username).sort
    name = usernames.join(":")

    if conversation = find_by(name: name)
      conversation
    else
      conversation = new(name: name)
      conversation.users = users
      conversation.save
      conversation
    end
  end

  def self.between(*users)
    users.map do |u|
      where("EXISTS(SELECT * FROM conversation_users uc WHERE uc.conversation_id = conversations.id AND uc.user_id = ?)", u)
    end.reduce(&:merge)
      .joins(:conversation_users)
      .group(:id)
      .having('count(*) = ?', users.length)
  end
end

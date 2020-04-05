class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable
  has_many :likes_by_users, through: :likes, source: :user
  has_many :comments, as: :commentable
  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def liked_by_user?(user)
    return false unless user

    likes_by_users.exists?(user.id)
  end
end

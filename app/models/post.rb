class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable
  has_many :likes_by_users, through: :likes, source: :user

  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc) }
end

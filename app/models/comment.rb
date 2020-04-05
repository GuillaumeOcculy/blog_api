class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :body, presence: true

  scope :old, -> { order(created_at: :asc) }
  scope :recent, -> { order(created_at: :desc) }

  def commented_by_user?(user)
    return false unless user

    self.user.id == user.id
  end
end

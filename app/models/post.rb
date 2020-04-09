class Post < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :user
  has_many :likes, as: :likeable
  has_many :likes_by_users, through: :likes, source: :user
  has_many :comments, as: :commentable

  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc) }

  before_save :image_derivatives!, if: -> { image.present? }

  def liked_by_user?(user)
    return false unless user

    likes_by_users.exists?(user.id)
  end

  def image_sizes
    if Rails.env.production?
      {
        small: image_url(:small),
        medium: image_url(:medium),
        large: image_url(:large),
        original: image_url
      }
    else
      return unless image

      base_url = ENV['IMAGE_BASE_URL']
      {
        small: base_url + image_url(:small),
        medium: base_url + image_url(:medium),
        large: base_url + image_url(:large),
        original: base_url + image_url
      }
    end
  end
end

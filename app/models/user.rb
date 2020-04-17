class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include Friendable
  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z]+\z/ }

  # Changes slug when first_name or last_name change
  def should_generate_new_friendly_id?
    username_changed? || super
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def token
    JsonWebToken.encode(sub: id)
  end

  private

  # Devise's method
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end

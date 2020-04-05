class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :first_name, :last_name, presence: true

  # Changes slug when first_name or last_name change
  def should_generate_new_friendly_id?
    first_name_changed? || last_name_changed? || super
  end

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :full_name,
      [:full_name, User.count]
    ]
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def token
    JsonWebToken.encode(sub: id)
  end
end

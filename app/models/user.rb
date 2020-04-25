class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  searchkick searchable: [:username], match: :word_middle

  include Friendable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :conversation_users, dependent: :destroy
  has_many :conversations, through: :conversation_users

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z]+\z/ }

  def self.find_by_slug(slug)
    find_by(username: slug) || find_by(id: slug)
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def token
    JsonWebToken.encode(sub: id, username: username)
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

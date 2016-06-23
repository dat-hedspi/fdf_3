class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :orders, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id", 
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id", 
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 50},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :phone_number, presence: true
  validates :address, presence: true, length: {maximum: 255}
  validates :password, presence: true, length: {minimum: 6}

  before_save :downcase_email
  has_secure_password

  private
  def downcase_email
    self.email = email.downcase
  end
end

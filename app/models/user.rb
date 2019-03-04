class User < ApplicationRecord
  has_secure_password
  has_many :messages
  validates :userName, presence: true, length: {minimum: 3, maximum: 20}, uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :userEmail, presence: true, uniqueness: {case_sesitive: false}, format: {with: VALID_EMAIL_REGEX}
end

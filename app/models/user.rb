class User < ApplicationRecord
  has_secure_password
  has_secure_password :recovery_password, validations: false
  attr_accessible :email, :password, :password_confirmation, :recovery_password,
                  :uid, :provider, :name, :created_at, :updated_at

  before_save { self.email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
            length: {maximum: 50}, format: { with: VALID_EMAIL_REGEX }
end

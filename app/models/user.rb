class User < ApplicationRecord
  has_secure_password

  attr_accessor :current_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_blank: true
end
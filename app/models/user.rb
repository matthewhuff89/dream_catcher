class User < ActiveRecord::Base
  # Remember to create a migration!
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, :format => /.+@.+\..+/
  has_many :dreams
  has_many :connections, through: :dreams
  has_many :words, through: :connections
end

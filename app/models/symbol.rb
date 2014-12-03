class Symbol < ActiveRecord::Base
  # Remember to create a migration!
  validates :name, presence: true
  has_many :connections
  has_many :dreams, through: :connections
end

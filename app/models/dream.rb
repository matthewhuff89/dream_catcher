class Dream < ActiveRecord::Base
  # Remember to create a migration!
  validates :title, {presence: true}
  validates :description, {presence: true}
  validates :dream_date, {presence: true}
  # May need to add a validation to check the format of the date also.
  belongs_to :user
  has_many :connections
  has_many :words, through: :connections
end

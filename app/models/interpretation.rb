class Interpretation < ActiveRecord::Base
validates :content, presence: true

belongs_to :dream
belongs_to :user
end
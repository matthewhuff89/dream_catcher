# This may fuck up (DreamSymbols), be prepared for that.
# UPDATE: Changed class name to Connection to nip that in the bud.
class Connection < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :dream
  belongs_to :word
end

class Contact < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  
end

class Recommendation < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :recommended, :class_name => "User"
end

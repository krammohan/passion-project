class User < ActiveRecord::Base
  has_many :contacts
  has_many :friends, through: :contacts
  has_many :recommendations
  has_many :recommendeds, through: :recommendations

  validates :email, presence: true
  validates :email, uniqueness: true

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(input_password)
    self.hashed_password = input_password
    @password = BCrypt::Password.create(input_password)
    self.hashed_password = @password
  end

  def self.authenticate(email, password)
    valid_user = User.find_by(email: email)
    valid_user.password == password ? valid_user : nil
  end

  def add_people
    people = User.all
    can_add = Array.new
    people.each do |person|
      if !self.friends.include?(person) && person != self
        can_add << person
      end
    end
    return can_add
  end

  def recommend_friends(location)
    people_to_recommend = Array.new
    self.friends.each do |friend|
      if friend.looking_for_contacts == "Yes" && friend.location == location
        people_to_recommend << friend
      end 
    end
    return people_to_recommend
  end

end

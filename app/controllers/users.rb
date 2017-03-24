
get '/users/new' do
  erb :'users/new'
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    login
    redirect "users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end

get '/users/:id' do
  if logged_in?
    @user = current_user
    @unrecommended = Array.new
    @unfriended = Array.new
    contacts = @user.friends.where(looking_for_contacts: "Yes")
    potentials = @user.recommendeds

    potentials.each do |pot|
      if !Contact.find_by(user_id: @user.id, friend_id: pot.id)
        @unfriended << pot
      end
    end
    
    contacts.each do |c|
      if !Recommendation.find_by(recommender_id: @user.id, user_id: c.id)
        @unrecommended << c
      end
    end

    erb :'users/show'
  else
    erb :'users/new'
  end
end

post '/users/not-looking' do
  @user = current_user
  @user.update_attribute(:looking_for_contacts, "No")
  redirect "/users/#{@user.id}"
end

post '/users/is-looking' do
  @user = current_user
  @user.update_attribute(:looking_for_contacts, "Yes")
  redirect "/users/#{@user.id}"
end
get '/people' do
	@user = current_user
	@people = @user.add_people
	erb :'/people/index'
end


post '/people/:friend_id' do
	@friend = User.find(params[:friend_id])
	@user= current_user
	if !Contact.find_by(user_id: @friend.id, friend_id: @user.id) && !Contact.find_by(user_id: @user.id, friend_id: @friend.id)
		Contact.create(user_id: @friend.id, friend_id: @user.id)
		Contact.create(user_id: @user.id, friend_id: @friend.id)
	end
	redirect "/users/#{@user.id}"
end

get '/people/:friend_id/recommend' do
	@friend = User.find(params[:friend_id])
	@user = current_user
	@contacts_to_recommend = @user.recommend_friends(@friend.location)

	if !Recommendation.find_by(recommender_id: @user.id, user_id: @friend.id) && !Recommendation.find_by(recommender_id: @friend.id, user_id: @user.id)
		@recommended_already = false
	else
		@recommended_already = true
	end

	erb :'/people/recommend'
end

post '/people/:friend_id/:contact_id' do
	@friend = User.find(params[:friend_id])
	@contact = User.find(params[:contact_id])
	if !Recommendation.find_by(recommender_id: current_user.id, user_id: @friend.id)
		@recommended_already = false
		Recommendation.create(user_id: @friend.id, recommended_id: @contact.id, recommender_id: current_user.id)
	else
		@recommended_already = true

	end
	redirect "/users/#{current_user.id}" 
end
get '/text/:friend_id' do
	@friend = User.find(params[:friend_id])
	erb :'texts/new'
end

post '/text/:friend_id' do
	number = "+1" + User.find(params[:friend_id]).phone
	body = params[:body]
	@client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']
 
 	@client.messages.create(
	  from: '+16696005418',
	  to: '+14087027862',
	  body: body
	)
	redirect "/users/#{current_user.id}/contacts"
end
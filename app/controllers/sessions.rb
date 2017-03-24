get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  @user = User.find_by_email(params[:email])
  if @user && @user.password == params[:password]
    login
    redirect "/users/#{@user.id}"
  else
    @errors = ["* Email and password don't match."]
    erb :'sessions/new'
  end
end

delete '/sessions/:id' do
  logout
  redirect '/'
end

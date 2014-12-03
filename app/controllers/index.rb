# TODO: Implement Error Handling.

get "/" do
 erb :'welcome'
end

post '/users/signup' do
  user = User.create(params[:user])
  session[:user_id] = user.id
  session[:username] = user.username
  redirect('/users/new_user')
end

get "/users/new_user" do
  erb :'users/new_user'
end

put "/users/new_user" do
  @user = User.find(session[:user_id])
  @user.update(params[:user])
  redirect("/#{@user.username}/new_dream")
end

# I need to make sure that random people can't just post dreams to anyone
# I need to set an error here too.
get "/:username/new_dream" do
  if session[:username] != params[:username]
    redirect("/")
  else
    erb :'dreams/new_dream'
  end
end

post "/:username/new_dream" do
  @user = User.find(session[:user_id])
  @dream = Dream.create(params[:dream])
  p @user
  @user.dreams << @dream
  redirect("/#{@user.username}/#{@dream.id}")
end

get "/:username/:dream_id" do
  @dream = Dream.find(params[:dream_id])
  erb :'dreams/show_dream'
end

# Add an error
get "/:username/home" do
  if session[:username] == params[:username]
    erb :'users/home'
  else
    redirect("/")
  end
end
# post '/users/login' do
#   user = User.find_by(username: params[:user][:username]).try(:authenticate, params[:user][:password])
#   if user
#     session[:username] = user.username
#     session[:user_id] = user.id
#     redirect("/welcome")
#   end
#   redirect("/users/login")
# end

get '/users/logout' do
  session[:username] = nil
  session[:user_id] = nil
  redirect("/")
end

# get '/welcome' do
#   if current_user == false
#     redirect("/login")
#   else
#     erb :welcome
#   end
# end
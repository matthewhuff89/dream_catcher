# TODO: Implement Error Handling.

get "/" do
 erb :'welcome'
end

get "/goodbye" do
  erb :goodbye
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
  redirect("/#{@user.username}/dreams/new_dream")
end

# I need to make sure that random people can't just post dreams to anyone
# I need to set an error here too.
get "/:username/home" do
  if session[:username] == params[:username]
    erb :'users/home'
  else
    redirect("/")
  end
end

delete '/:username/delete' do
  @user = User.find(session[:user_id])
  @user.dreams.destroy_all
  @user.destroy
  session[:username] = nil
  session[:user_id] = nil
  redirect("/goodbye")
end

get "/:username/profile" do
  @user = User.find(session[:user_id])
  erb :'users/profile'
end

get "/:username/profile/edit" do
  erb :'users/edit_profile'
end

put "/:username/profile/edit" do
  @user = User.find(session[:user_id])
  @user.update(params[:user])
  redirect("/#{@user.username}/profile")
end


get "/:username/dreams/new_dream" do
  if session[:username] != params[:username]
    redirect("/")
  else
    erb :'dreams/new_dream'
  end
end

post "/:username/dreams/new_dream" do
  @user = User.find(session[:user_id])
  @dream = Dream.create(params[:dream])
  p @user
  @user.dreams << @dream
  redirect("/#{@user.username}/dreams/#{@dream.id}")
end

get "/:username/dreams/all" do
  @dreams = User.find(session[:user_id]).dreams
  erb :'dreams/all'
end

get "/:username/dreams/:dream_id" do
  @dream = Dream.find(params[:dream_id])
  erb :'dreams/show_dream'
end

get "/:username/dreams/:dream_id/edit" do
  @dream = Dream.find(params[:dream_id])
  erb :'dreams/edit_dream'
end

put "/:username/dreams/:dream_id/edit" do
  @dream = Dream.find(params[:dream_id])
  @dream.update(params[:dream])
  redirect("/#{@dream.user.username}/dreams/#{@dream.id}")
end
# Add an error

post '/users/login' do
  user = User.find_by(username: params[:user][:username]).try(:authenticate, params[:user][:password])
  if user
    session[:username] = user.username
    session[:user_id] = user.id
    redirect("/#{user.username}/home")
  end
  redirect("/")
end

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
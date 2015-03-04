after { ActiveRecord::Base.connection.close }

get "/" do
  if current_user
   erb :'users/home'
  else
   erb :'welcome'
  end
end


post '/users/login' do
  user = User.find_by(username: params[:user][:username]).try(:authenticate, params[:user][:password])
  if user
    session[:username] = user.username
    session[:user_id] = user.id
    redirect("/#{user.username}/home")
  else
    set_error("Something ain't right here, either with your password or your username")
    redirect("/")
  end
end


post '/users/signup' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    session[:username] = user.username
    redirect('/users/new_user')
  else
    session[:error] = user.errors.messages
    redirect("/")
  end
end

get "/users/new_user" do
 if current_user
    erb :'users/new_user'
 else
  set_error("You ain't logged in. You can't go there")
  redirect("/")
 end
end

put "/users/new_user" do
  @user = User.find(session[:user_id])
  @user.update(params[:user])
  redirect("/#{@user.username}/dreams/new_dream")
end

get '/users/logout' do
  session[:username] = nil
  session[:user_id] = nil
  redirect("/")
end
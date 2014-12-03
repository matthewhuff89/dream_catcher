# TODO: Implement Error Handling.

get "/" do
  if current_user
   erb :'users/home'
  else
   erb :'welcome'
  end
end

get "/goodbye" do
  erb :goodbye
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

get "/error" do
  erb :'errors/error_display'
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

# I need to make sure that random people can't just post dreams to anyone
# I need to set an error here too.
get "/:username/home" do
  if current_user && session[:username] == params[:username]
    erb :'users/home'
  else
    if current_user
      set_error("Nope. You can't go there bro. Log in if you want to go there.")
      redirect("/#{session[:username]}/home")
    else
      redirect("/")
    end
  end
end

get "/:username/delete" do
  if current_user && session[:username] == params[:username]
   erb :'users/delete'
  else
    set_error("Nope. You can't do that bro. Delete your own damn account")
    redirect("/#{session[:username]}/home")
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
  if current_user && session[:username] == params[:username]
    erb :'users/edit_profile'
  else
    set_error("Nope, you can't edit that profile")
    redirect("/")
  end
end

put "/:username/profile/edit" do
  @user = User.find(session[:user_id])
  @user.update(params[:user])
  redirect("/#{@user.username}/profile")
end


get "/:username/dreams/new_dream" do
  if current_user && session[:username] == params[:username]
    erb :'dreams/new_dream'
  else
    set_error("Nope. Gotta make dreams from your own account.")
    redirect("/")
  end
end

post "/:username/dreams/new_dream" do
  @user = User.find(session[:user_id])
  @dream = Dream.create(params[:dream])
  @words = word_creator(word_splitter(params[:words]))
  @words.each { |word| @dream.words << word}
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
  if current_user && session[:username] == params[:username]
    @dream = Dream.find(params[:dream_id])
   erb :'dreams/edit_dream'
 else
    set_error("You can't edit someone else's dreams. This ain't Inception")
    redirect("/")
  end
end

put "/:username/dreams/:dream_id/edit" do
  @dream = Dream.find(params[:dream_id])
  @dream.update(params[:dream])
  @words = word_creator(word_splitter(params[:words]))
  @words.uniq.each { |word| @dream.words << word}
  @user = User.find_by(username: params[:username])
  @user.dreams << @dream
  redirect("/#{@dream.user.username}/dreams/#{@dream.id}")
end
# Add an error



get '/users/logout' do
  session[:username] = nil
  session[:user_id] = nil
  redirect("/")
end

get '/:username/words/all' do
  @user = User.find_by(username: params[:username])
  @words = @user.words.uniq
  erb :'words/all_words'
end

get '/:username/words/:name' do
  @word = Word.find_by(name: params[:name])
  erb :'words/show_word'
end



# get '/welcome' do
#   if current_user == false
#     redirect("/login")
#   else
#     erb :welcome
#   end
# end
after { ActiveRecord::Base.connection.close }

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

# User Delete Control Flow
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

get "/goodbye" do
  erb :goodbye
end
# End User Delete Flow

# User Profile Flow
get "/:username/profile" do
  @user = User.find(session[:user_id])
  erb :'users/profile'
end

get "/:username/profile/edit" do
  if current_user && session[:username] == params[:username]
    @user = User.find(session[:user_id])
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
# End User Profile Flow



# Dream Creation Flow
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
  @words.uniq.each { |word| @dream.words << word}
  @user.dreams << @dream
  redirect("/#{@user.username}/dreams/#{@dream.id}")
end
# Dream Create Flow


# Dream Read Flow
get "/:username/dreams/all" do
  @dreams = User.find(session[:user_id]).dreams
  erb :'dreams/all'
end

get "/:username/dreams/:dream_id" do
  @dream = Dream.find(params[:dream_id])
  erb :'dreams/show_dream'
end
# End Dream Read Flow


# Dream Update Flow
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
  @words.uniq.each { |word| @dream.words.find_or_create_by(name: word.name)}
  @user = User.find_by(username: params[:username])
  @user.dreams << @dream
  redirect("/#{@dream.user.username}/dreams/#{@dream.id}")
end
# End Dream Update Flow

# Dream Destroy Flow
delete '/:username/dreams/:dream_id' do
  @dream = Dream.find(params[:dream_id])
  @dream.destroy
  redirect("/#{params[:username]}/dreams/all")
end


# Words Read Flow
get '/:username/words/all' do
  @user = User.find_by(username: params[:username])
  @words = @user.words.uniq
  erb :'words/all_words'
end

get '/:username/words/:name' do
  @word = Word.find_by(name: params[:name])
  erb :'words/show_word'
end
# Words End

# Interpretations
post '/:username/dreams/:dream_id' do
  @interpretation = Interpretation.create(params[:interpretation])
  redirect("/#{@dream.user.username}/dreams/#{@dream.id}")
end




# get '/welcome' do
#   if current_user == false
#     redirect("/login")
#   else
#     erb :welcome
#   end
# end
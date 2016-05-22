# Controller for logging in users
class SessionsController < ApplicationController

  def new

    if current_user
      flash[:warning] = "You're already logged in, clown!"
      redirect_to groups_path
      #redirect_to memes_path(current_user.groups.first.group_slug)
    end

    # This is the action associated with logging in (get request)
    # renders new.html.erb, then submits heads DOWN to....(sessions#create)
    # | | | | | |
    # V V V V V V  jacob i wrote this for you to get mad.
  end

  def create  #create a session
    # This is the action associated with logging in (post request)
    # This finds the user id and adds it to his/her cookie

    # @user = User.find(params[:user][:id])
    @user = User.find_by(username: user_params[:username])
    if @user.authenticate(user_params[:password])
      #make active sesh, bring up first group of their groups
      session[:user_id] = @user.id
      redirect_to groups_path
      #redirect_to memes_path(@user.groups.first.group_slug)
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path
  end

  private
 	def user_params
     params.require(:user).permit(:username, :password)
 	end

end

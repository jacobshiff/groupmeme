# Controller for logging in users
class SessionsController < ApplicationController

  def new

    if current_user
      flash[:warning] = "You are already logged in"
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

    @user = User.find_by(username: user_params[:username])
    # if the user exists...
    if @user
      # ... then authenticate that the password is correct
      # binding.pry
      if @user.authenticate(user_params[:password])
        #make active sesh, bring up first group of their groups
        session[:user_id] = @user.id
        if @user.groups.count == 1
          redirect_to group_path(@user.groups.first.group_slug)
        else
          redirect_to groups_path
        end
      else
        flash.now[:danger] = "Please confirm that you entered your username and password correctly."
        render :new
      end
    else
      flash.now[:danger] = "Please confirm that you entered your username and password correctly."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to home_path
  end

  private
 	def user_params
     params.require(:user).permit(:username, :password)
 	end

end

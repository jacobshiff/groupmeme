#Controller for creating new users
class RegistrationsController < ApplicationController

  def new
    if current_user
      flash[:danger] = "You are already logged in."
      redirect_to groups_path
      #redirect_to memes_path(current_user.groups.first.group_slug)
    end
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      binding.pry
      session[:user_id] = @user.id
      redirect_to groups_path
      #redirect_to memes_path(@user.groups.first.group_slug)
      #if there is an error in registration, the error message carries through to the group/memes index??
    else
      binding.pry
      error_type
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar, :group_ids)
  end

  def user_avatar
    params.require(:user).permit(:avatar)
  end

  def error_type
    if @user.errors.messages[:password_confirmation]
      flash[:danger] = "Your passwords do not match. Please try again."
    elsif @user.errors.messages[:username]
      flash[:danger] = "#{@user.username} has already been taken. Please try another username."
      # add in flash check for password is too short
    elsif @user.errors.messages[:password]
      flash[:danger] = "Passwords must be at least 6 characters. Please try again."
    end
  end

end

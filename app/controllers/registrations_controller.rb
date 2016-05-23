#Controller for creating new users
class RegistrationsController < ApplicationController

  def new
    if current_user
      flash[:danger] = "You are already logged in."
      redirect_to groups_path
      #redirect_to memes_path(current_user.groups.first.group_slug)
    end
      @token = params[:invite_token]
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    @token = params[:invite_token]
    # if successfully saved user
    if @user.save
      session[:user_id] = @user.id
      # then associate the new user with the group to which he was invited
      if @token != nil
        group = Invite.find_by(token: @token).group
        @user.groups << group
        redirect_to groups_path
      end
      #if there is an error in registration, the error message carries through to the group/memes index??
    else
      error_type
      render :new
    end
  end

  def add_group_to_existing
    binding.pry
    @token = params[:invite_token]
    @user = Invite.find_by(token: @token).recipient
    @group = Invite.find_by(token: @token).group

    if @user.groups.include?(@group)
      flash[:danger] = "#{@user.username} is already a member of #{@group.title}. Please sign in."
      redirect_to groups_path
    end
  end
  
  def add_group_to_existing_create
    token = params[:invite_token]
    if token != nil
      recipient = Invite.find_by(token: token).recipient
      group = Invite.find_by(token: token).group
      recipient.groups << group
      redirect_to groups_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar, :invite_token)
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

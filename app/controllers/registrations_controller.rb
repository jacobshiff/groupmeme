#Controller for creating new users
class RegistrationsController < ApplicationController

  #New action for brand new user (new email/username AND group)
  def new
    if !capture_token_from_params
      flash[:danger] = "You need an invite to join GroupMeme."
      redirect_to '/'
    elsif current_user
      flash[:danger] = "You are already logged in."
      redirect_to groups_path
    else
      capture_token_from_params
      @user = User.new
      @user.email = Invite.find_by(token: @token).recipient_email
    end
  end

  #Create action for brand new user (new email/username AND group)
  def create
    @user = User.new(user_params)
    token = params[:user][:invite_token]
    if @user.save # if successfully saved user...
      session[:user_id] = @user.id #... then set session_id
      if token # ...and associate the new user with the group to which he was invited
        group = Invite.find_by(token: token).group
        @user.groups << group
        redirect_to memes_path(group.group_slug)
      else
        flash[:danger] = "You do not have permission to join this group. Please contact the administrator."
        redirect_to groups_path
      end
    else
      #if there is an error in registration, the error message carries through to the group/memes index??
      error_type
      render :new
    end
  end

  #New action for existing user who is adding a new group
  def add_group_to_existing
    if !capture_token_from_params
      flash[:danger] = "You need an invite to join GroupMeme."
      redirect_to groups_path
    elsif
      capture_token_from_params
      @user = Invite.find_by(token: @token).recipient #Set user, based on invite token
      @group = Invite.find_by(token: @token).group #Set invited group, based on invite token

      if @user.groups.include?(@group) #Check if already a member of that group
        flash[:danger] = "#{@user.username} is already a member of #{@group.title}. Please sign in."
        redirect_to login_path
      end
    end
  end

  #Create action for existing user who is adding a new group
  def add_group_to_existing_create
    capture_token_from_params
    if @token
      recipient = Invite.find_by(token: @token).recipient
      group = Invite.find_by(token: @token).group
      recipient.groups << group
      flash[:success] = "You have successfully added #{group.title} to your account. Please log in to view."
      redirect_to login_path
    else
      flash[:danger] = "You do not have permission to join this group. Please contact the administrator."
      redirect_to groups_path
    end
  end

  private

  def capture_token_from_params
    @token = params[:invite_token]
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
  end

  def user_avatar
    params.require(:user).permit(:avatar)
  end

  def error_type
    if @user.errors.messages[:password_confirmation]
      flash.now[:danger] = "Your passwords do not match. Please try again."
    elsif @user.errors.messages[:username]
      flash.now[:danger] = "#{@user.username} has already been taken. Please try another username."
      # add in flash check for password is too short
    elsif @user.errors.messages[:password]
      flash.now[:danger] = "Passwords must be at least 6 characters. Please try again."
    end
  end

end

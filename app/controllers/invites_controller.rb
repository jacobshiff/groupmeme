class InvitesController < ApplicationController

  def new
    if !current_user #check if logged in
      flash[:danger] = "Please log in."
      redirect_to login_path
    elsif current_user.type(current_group) == "admin" || current_user.type(current_group) == "moderator" #check if have correct permissions
      @invite = Invite.new
      @invite.group = current_group
    else
      flash[:danger] = "You are not authorized to invite new users to that group."
      redirect_to groups_path
    end
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.sender = current_user

    if @invite.save
      # if the user already exists...
      if @invite.recipient_id
        # ... send the existing user template
        InviteMailer.existing_user_invite(@invite).deliver
      # otherwise, if the user does not yet exist
      else
        # send the new user template
        InviteMailer.new_user_invite(@invite).deliver
      end

      flash[:success] = "Your invite was successfully sent."
      redirect_to invite_new_path(current_group.group_slug)
    else
      flash[:danger] = "Your invite did not send successfully. Please try again."
      redirect_to invite_new_path(current_group.group_slug)
    end


  end

  private

  def invite_params
    params.require(:invite).permit(:recipient_email, :group_id)
  end
end

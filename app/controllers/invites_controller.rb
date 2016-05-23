class InvitesController < ApplicationController

  def new
    if !current_user
      flash[:danger] = "Please log in."
      redirect_to login_path
    else
      @invite = Invite.new
      @invite.group = current_group
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

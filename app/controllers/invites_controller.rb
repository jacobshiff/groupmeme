class InvitesController < ApplicationController

  def new
    @invite = Invite.new
    @invite.group = current_group
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.sender = current_user
    if @invite.save
      InviteMailer.new_user_invite(@invite).deliver
      flash[:success] = "Your invite was successfully sent."
      # render :new
      redirect_to invite_new_path(current_group.group_slug)
    else
      #some stuff to catch an exception
    end


  end

  private

  def invite_params
    params.require(:invite).permit(:recipient_email, :group_id)
  end
end

class InviteMailer < ApplicationMailer

  def new_user_invite(invite)
    @link = registration_new_path(:invite_token => invite.token)
    @invite = invite
    mail to: invite.recipient_email, subject: "You have been invited to #{invite.group.title}'s GroupMeme"
  end

  def existing_user_invite(invite)
    @link = add_group_to_existing_path(:invite_token => invite.token)
    @invite = invite
    mail to: invite.recipient_email, subject: "You have been invited to #{invite.group.title}'s GroupMeme"
  end
end

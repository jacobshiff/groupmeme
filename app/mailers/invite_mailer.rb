class InviteMailer < ApplicationMailer

  def new_user_invite(invite)
    @link = registration_new_path(:invite_token => invite.token)
    mail to: invite.recipient_email, subject: "You've been invited to #{invite.group.title}'s GroupMeme"
  end
end

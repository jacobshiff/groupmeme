class AddInviteeEmailToInvitations < ActiveRecord::Migration
  def change
    rename_column :invites, :inviter_id, :sender_id
    remove_column :invites, :invitee_id
    add_column :invites, :recipient_email, :string
    add_column :invites, :token, :string
  end
end

class AddRecipientIdToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :recipient_id, :integer, index: true
  end
end

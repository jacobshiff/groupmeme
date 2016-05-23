class AddIndexToInvites < ActiveRecord::Migration
  def change
    add_index :invites, :recipient_id
  end
end

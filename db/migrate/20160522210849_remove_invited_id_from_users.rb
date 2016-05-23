class RemoveInvitedIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :invite_id
  end
end

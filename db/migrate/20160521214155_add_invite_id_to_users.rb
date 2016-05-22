class AddInviteIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invite_id, :integer
    add_index :users, :invite_id
  end
end

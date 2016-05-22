# Removes the carrier wave DB migration
class RemoveAvatarFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avatar
  end
end

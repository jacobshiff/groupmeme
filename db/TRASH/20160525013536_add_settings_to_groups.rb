class AddSettingsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :expiration, :boolean
    add_column :groups, :public, :boolean
    add_column :groups, :view_users, :boolean
  end
end

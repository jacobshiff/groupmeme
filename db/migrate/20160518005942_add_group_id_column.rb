class AddGroupIdColumn < ActiveRecord::Migration
  def change
    add_column :comments, :group_id, :integer
    add_column :invites, :group_id, :integer
    add_column :meme_tags, :group_id, :integer
    add_column :memes, :group_id, :integer
    add_column :reactions, :group_id, :integer
    add_column :tags, :group_id, :integer
    add_column :users, :group_id, :integer
  end
end
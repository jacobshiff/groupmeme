class AddIndexForForeignKeys < ActiveRecord::Migration
  def change
    add_index :comments, :user_id
    add_index :comments, :meme_id
    add_index :comments, :group_id
    add_index :groups, :group_creator_id
    add_index :groups, :group_slug
    add_index :invites, :inviter_id
    add_index :invites, :invitee_id
    add_index :invites, :group_id
    add_index :memberships, :group_id
    add_index :memberships, :user_id
    add_index :meme_tags, :tag_id
    add_index :meme_tags, :meme_id
    add_index :meme_tags, :group_id
    add_index :reactions, :group_id
    add_index :reactions, :meme_id
    add_index :reactions, :user_id
    add_index :tags, :group_id
  end
end

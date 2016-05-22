#adds in migration for PaperClip
class AddAttachmentAvatarToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :avatar
  end
end

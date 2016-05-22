class AddAttachmentColumnToMemes < ActiveRecord::Migration
  def change
    add_attachment :memes, :image
  end
end

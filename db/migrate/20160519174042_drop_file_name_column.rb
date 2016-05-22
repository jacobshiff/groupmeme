class DropFileNameColumn < ActiveRecord::Migration
  def change
    remove_column :memes, :file_name
  end
end

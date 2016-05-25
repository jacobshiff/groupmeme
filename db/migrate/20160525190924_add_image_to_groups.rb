class AddImageToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :image_file_name, :string 
  end
end

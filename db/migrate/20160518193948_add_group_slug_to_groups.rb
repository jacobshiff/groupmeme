class AddGroupSlugToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :group_slug, :string
  end
end

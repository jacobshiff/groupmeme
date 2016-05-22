class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.integer :group_creator_id
      t.timestamps null: false
    end
  end
end

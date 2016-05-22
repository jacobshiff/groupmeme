class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :user_type
      t.timestamps null: false
    end
  end
end

class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :file_name
      t.integer :creator_id
      t.timestamps null: false
    end
  end
end

class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.integer :meme_id
      t.integer :user_id
      t.string :type
      t.timestamps null: false
    end
  end
end

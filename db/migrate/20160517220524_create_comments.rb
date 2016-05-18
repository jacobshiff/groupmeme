class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :user_id,
      t.text :content,
      t.string :meme_id,
      t.timestamps null: false
    end
  end
end

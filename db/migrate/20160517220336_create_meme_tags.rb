class CreateMemeTags < ActiveRecord::Migration
  def change
    create_table :meme_tags do |t|
      t.integer :tag_id
      t.integer :meme_id
      t.timestamps null: false
    end
  end
end

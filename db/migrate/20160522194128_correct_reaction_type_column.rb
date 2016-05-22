class CorrectReactionTypeColumn < ActiveRecord::Migration
  def change
    rename_column :reactions, :type, :reaction_type
  end
end

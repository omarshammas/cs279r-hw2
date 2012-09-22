class RemovePreferenceFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :preference
  end

  def down
    add_column :users, :preference, :string
  end
end

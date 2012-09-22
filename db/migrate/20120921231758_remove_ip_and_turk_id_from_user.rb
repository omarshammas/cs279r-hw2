class RemoveIpAndTurkIdFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :ip
    remove_column :users, :turk_id
  end

  def down
    add_column :users, :turk_id, :string
    add_column :users, :ip, :string
  end
end

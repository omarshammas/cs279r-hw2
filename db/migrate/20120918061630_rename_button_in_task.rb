class RenameButtonInTask < ActiveRecord::Migration
  def up
  	rename_column :tasks, :button, :button_id
  end

  def down
  end
end

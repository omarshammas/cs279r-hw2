class AddParentSwitchToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :parent_switch, :boolean
  end
end

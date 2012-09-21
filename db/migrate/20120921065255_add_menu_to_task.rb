class AddMenuToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :menu, :string
  end
end

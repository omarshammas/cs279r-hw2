class AddInitialInterfaceToUser < ActiveRecord::Migration
  def change
    add_column :users, :initial_interface, :string
  end
end

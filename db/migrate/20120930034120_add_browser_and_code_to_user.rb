class AddBrowserAndCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :browser, :string
    add_column :users, :code, :string
  end
end

class AddAgeAndGenderAndInputDeviceToUser < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :input_device, :string
  end
end

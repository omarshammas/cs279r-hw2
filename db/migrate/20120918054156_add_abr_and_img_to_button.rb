class AddAbrAndImgToButton < ActiveRecord::Migration
  def change
    add_column :buttons, :abr, :string
    add_column :buttons, :img, :string
  end
end

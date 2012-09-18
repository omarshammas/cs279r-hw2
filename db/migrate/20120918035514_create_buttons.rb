class CreateButtons < ActiveRecord::Migration
  def change
    create_table :buttons do |t|
      t.string :name
      t.string :parent

      t.timestamps
    end
  end
end

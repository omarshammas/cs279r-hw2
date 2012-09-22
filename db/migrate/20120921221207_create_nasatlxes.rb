class CreateNasatlxes < ActiveRecord::Migration
  def change
    create_table :nasatlxes do |t|
      t.decimal :mental
      t.decimal :physical
      t.decimal :temporal
      t.decimal :performance
      t.decimal :effort
      t.decimal :frustration
      t.string :menu
      t.integer :user_id

      t.timestamps
    end
  end
end

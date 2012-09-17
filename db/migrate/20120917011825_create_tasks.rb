class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :button
      t.integer :time
      t.integer :errors
      t.string :block
      t.integer :position
      t.integer :user_id

      t.timestamps
    end
  end
end

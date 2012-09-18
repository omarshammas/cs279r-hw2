class FixErrorsNameInTask < ActiveRecord::Migration
  def up
  	rename_column :tasks, :errors, :bad_clicks
  end

  def down
  end
end

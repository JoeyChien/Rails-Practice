class AddEndTimeToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :end_time, :datetime
  end
end

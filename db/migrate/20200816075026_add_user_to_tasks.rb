class AddUserToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :user, null: false, foreign_key: true, index: true, default: 1
  end
end
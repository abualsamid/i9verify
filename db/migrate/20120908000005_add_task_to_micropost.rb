class AddTaskToMicropost < ActiveRecord::Migration
  def change
	add_column :microposts, :task_id, :integer
  end
end

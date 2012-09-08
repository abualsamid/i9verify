class AddIndexOnTaskToMicroposts < ActiveRecord::Migration
  def change
	add_index :microposts,[:task_id]
  end
end

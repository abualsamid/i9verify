class Add < ActiveRecord::Migration
  def up
		add_column :tasks, :duetime, :time	
  end

  def down
  	drop_column :tasks, :duetime
  end
end

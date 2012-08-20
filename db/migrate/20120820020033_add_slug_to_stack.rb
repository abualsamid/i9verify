class AddSlugToStack < ActiveRecord::Migration
  def change
	add_column :stacks, :slug, :string, null: false, default: ''	
	
  end	
end

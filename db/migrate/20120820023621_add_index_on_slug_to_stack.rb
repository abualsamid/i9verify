class AddIndexOnSlugToStack < ActiveRecord::Migration
  def change
  	add_index :stacks, [:user_id, :slug], unique: true
  end
end

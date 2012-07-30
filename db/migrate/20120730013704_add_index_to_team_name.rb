class AddIndexToTeamName < ActiveRecord::Migration
  def change
    add_index :teams, [:user_id, :name] , unique: true
  end
end

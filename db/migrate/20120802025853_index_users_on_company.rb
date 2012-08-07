class IndexUsersOnCompany < ActiveRecord::Migration
  def up
    add_index :users, :company_id
  end

  def down
    drop_index :users, :company_id
  end
end

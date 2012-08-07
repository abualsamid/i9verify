class AddCompanyToUser < ActiveRecord::Migration
  def change
    add_column :users, :company_id, :integer, null: false, default: 0
    User.update_all ["company_id = ? ",0]
  end
end

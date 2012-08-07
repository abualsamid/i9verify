class CreateStacks < ActiveRecord::Migration
  def change
    create_table :stacks do |t|
      t.string :name, null: false, default: ""
      t.references :user
      t.references :company

      t.timestamps
    end
    add_index :stacks, :user_id
    add_index :stacks, :company_id
  end
end

class CreateTasks < ActiveRecord::Migration
  def change
    create_table :status do |t|
      t.string :name, null: false, default: ""
      t.integer :sequence, null: false, default: 999
      t.boolean :isActive, null: false, default: true
      t.timestamps
    end
    create_table :tasks do |t|
      t.belongs_to :company , null: false
      t.belongs_to :user , null: false
      t.belongs_to :stack, null: false
      t.string :name, null: false, default: ""
      t.text :description,  null: false, default: ""
      t.datetime :due
      t.references :status, null: false, default: 0
      t.integer :priority, null: false, default: 1

      t.timestamps
    end
    add_index :tasks, :stack_id
    add_index :tasks, [:company_id, :user_id]
  end
end

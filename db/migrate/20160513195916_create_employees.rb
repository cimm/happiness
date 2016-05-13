class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees, force: true do |t|
      t.string :email, null: false
      t.string :uid, null: false
      t.timestamps null: false
    end
    add_index :employees, :uid, unique: true
  end
end

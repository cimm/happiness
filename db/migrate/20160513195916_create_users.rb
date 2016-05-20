class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :email,      null: false
      t.date       :deleted_at
      t.timestamps              null: false
    end
    add_index :users, :email, unique: true
  end
end

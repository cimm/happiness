class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text       :body,       null: false
      t.string     :regularity, null: false
      t.timestamps              null: false
    end
  end
end

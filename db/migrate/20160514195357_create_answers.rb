class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user, null: false
      t.references :survey,   null: false
      t.references :question, null: false
      t.integer    :score
    end
  end
end

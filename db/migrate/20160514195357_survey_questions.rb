class SurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.references :survey,   null: false
      t.references :question, null: false
    end
  end
end

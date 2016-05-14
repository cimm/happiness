class Survey < ActiveRecord::Base
  NUMBER_OF_RANDOM_QUESTIONS_PER_SURVEY = ENV.fetch('NUMBER_OF_RANDOM_QUESTIONS_PER_SURVEY').to_i

  has_many :survey_questions, dependent: :destroy
  has_many :questions, through: :survey_questions

  def self.generate
    survey = self.new
    survey.questions = Question.fixed_regularity + Question.random_regularity.shuffle[0...NUMBER_OF_RANDOM_QUESTIONS_PER_SURVEY]
    survey
  end
end

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :answers
  has_many :surveys, -> { uniq }, through: :answers

  def answers_for_survey(survey)
    answers.where(survey: survey)
  end
end

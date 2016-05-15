class Employee < ActiveRecord::Base
  validates :email, :uid, presence: true
  validates :uid, uniqueness: true

  has_many :answers

  def answers_for_survey(survey)
    answers.where(survey: survey)
  end
end

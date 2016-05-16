class User < ActiveRecord::Base
  validates :email, :uid, presence: true
  validates :uid, uniqueness: true

  has_many :answers
  has_many :surveys, -> { uniq }, through: :answers

  def answers_for_survey(survey)
    answers.where(survey: survey)
  end
end

class User < ActiveRecord::Base
  before_validation { self.email = self.email.downcase }

  validates :email, presence: true, uniqueness: true

  has_many :answers
  has_many :surveys, -> { uniq }, through: :answers

  scope :active,   -> { where(deleted_at: nil) }
  scope :inactive, -> { where.not(deleted_at: nil) }

  def answers_for_survey(survey)
    answers.where(survey: survey)
  end
end

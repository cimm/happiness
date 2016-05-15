class Answer < ActiveRecord::Base
  validates :user, :question, :survey, presence: true
  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }, allow_nil: true

  belongs_to :user
  belongs_to :question
  belongs_to :survey

  scope :answered, -> { where.not(score: nil) }
end

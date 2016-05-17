class Answer < ActiveRecord::Base
  MAX_SCORE = 4

  validates :user, :question, :survey, presence: true
  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: MAX_SCORE }, allow_nil: true

  belongs_to :user
  belongs_to :question
  belongs_to :survey

  scope :answered, -> { where.not(score: nil) }
  scope :since, ->(since) { where('created_at >= ?', since) }
end

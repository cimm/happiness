class Question < ActiveRecord::Base
  REGULARITIES = %w(fixed flexible)

  validates :body, :regularity, presence: true
  validates :regularity, inclusion: { in: REGULARITIES }

  has_many :answers
  has_many :users, -> { uniq }, through: :answers

  scope :fixed_regularity, -> { where regularity: 'fixed' }
  scope :flexible_regularity, -> { where regularity: 'flexible' }

  def scores(since = Time.at(0))
    answers.since(since).pluck(:score).compact
  end

  def respondents(since = Time.at(0))
    answers.since(since).map(&:user).compact
  end

  def happiness_score(since = Time.at(0))
    scores = self.scores(since)
    return 0 if scores.none?
    average = (scores.sum.to_f / scores.count)
    score = average * (100 / Answer::MAX_SCORE)
    score.round
  end
end

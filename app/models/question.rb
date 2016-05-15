class Question < ActiveRecord::Base
  REGULARITIES = %w(fixed random)

  validates :body, :regularity, presence: true
  validates :regularity, inclusion: { in: REGULARITIES }

  has_many :answers

  scope :fixed_regularity, -> { where regularity: 'fixed' }
  scope :random_regularity, -> { where regularity: 'random' }

  def scores
    @scores ||= answers.pluck(:score)
  end

  def happiness_score(since = Time.at(0))
    [
      scores.count(0) * -3,
      scores.count(1) * -2,
      scores.count(2),
      scores.count(3) * 2,
      scores.count(4) * 3
    ].sum
  end
end

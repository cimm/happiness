class Question < ActiveRecord::Base
  REGULARITIES = %w(fixed random)

  validates :body, :regularity, presence: true
  validates :regularity, inclusion: { in: REGULARITIES }

  scope :fixed_regularity, -> { where regularity: 'fixed' }
  scope :random_regularity, -> { where regularity: 'random' }
end

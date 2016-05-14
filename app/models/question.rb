class Question < ActiveRecord::Base
  REGULARITIES = %w(fixed random)

  validates :body, :regularity, presence: true
  validates :regularity, inclusion: { in: REGULARITIES }
end

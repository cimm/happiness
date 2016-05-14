class SurveyQuestion < ActiveRecord::Base
  validates :question, :survey, presence: true

  belongs_to :question
  belongs_to :survey
end

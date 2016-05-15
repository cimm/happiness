class Survey < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :questions, through: :answers
end

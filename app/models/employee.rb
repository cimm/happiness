class Employee < ActiveRecord::Base
  validates :email, :uid, presence: true
  validates :uid, uniqueness: true
end

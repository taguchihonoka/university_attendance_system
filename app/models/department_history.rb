class DepartmentHistory < ApplicationRecord
  belongs_to :user
  belongs_to :department
  validates :started_date, presence: true
end

class LeaveRecord < ApplicationRecord
  belongs_to :user
  validates :leave_of_absence_start_date, presence: true
end

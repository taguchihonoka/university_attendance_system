# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :user
  belongs_to :department
  validates :attendance_number, presence: true
  validates :department, presence: true
  validates :grade, presence: true
  validates :enrolled_date: presence: true
end

# frozen_string_literal: true

class Teacher < ApplicationRecord
  belongs_to :user
  belongs_to :department
  belongs_to :position
  validates :instructor_number, presence: true
  validates :department, presence: true
  validates :position, presence: true
  validates :assigned_date, presence: true
end

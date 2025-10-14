# frozen_string_literal: true

class Department < ApplicationRecord
  belongs_to :faculty
  validates :name, presence: true
end

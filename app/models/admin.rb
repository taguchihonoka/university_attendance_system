# frozen_string_literal: true

class Admin < ApplicationRecord
  belongs_to :user
  validates :admin_number, presence: true
  validates :joined_date, presence: true
end

# frozen_string_literal: true

class Position < ApplicationRecord
  validates :name, presence: true
end

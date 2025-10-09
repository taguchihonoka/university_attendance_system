# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :role
  has_one :student
  has_one :teacher
  has_one :admin
  has_many :leave
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :password, presence: true
  validates :identifier, presence: true, uniqueness: true
  has_secure_password
end

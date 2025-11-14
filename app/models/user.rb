# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :role
  has_one :student, dependent: :destroy
  has_one :teacher, dependent: :destroy
  has_one :admin, dependent: :destroy
  has_many :leave_records, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :identifier, presence: true, uniqueness: true
  has_secure_password

  # フルネームを表示する
  def name
    "#{first_name} #{last_name}"
  end
end

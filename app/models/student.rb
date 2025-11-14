# frozen_string_literal: true

# rubocop:disable Naming/VariableNumber
class Student < ApplicationRecord
  # 学年入力のセレクトボックス用
  enum :grade, {
    undergraduate_1: 1,
    undergraduate_2: 2,
    undergraduate_3: 3,
    undergraduate_4: 4,
    master_1: 5,
    master_2: 6,
    doctor_1: 7,
    doctor_2: 8,
    doctor_3: 9
  }

  GRADE_LABEL = {
    undergraduate_1: '学部1年',
    undergraduate_2: '学部2年',
    undergraduate_3: '学部3年',
    undergraduate_4: '学部4年',
    master_1: '修士1年',
    master_2: '修士2年',
    doctor_1: '博士1年',
    doctor_2: '博士2年',
    doctor_3: '博士3年'
  }.freeze

  belongs_to :user
  belongs_to :department
  validates :attendance_number, presence: true
  validates :grade, presence: true
  validates :enrolled_date, presence: true

  # 表示を日本語にする
  def grade_label
    GRADE_LABEL[grade.to_sym]
  end
end
# rubocop:enable Naming/VariableNumber

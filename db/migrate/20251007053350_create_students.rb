# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.references :user, null: false, foreign_key: true
      t.string :attendance_number, null: false
      t.references :department, null: false, foreign_key: true
      t.integer :grade, null: false
      t.date :enrolled_date, null: false
      t.date :graduated_date
      t.date :dropout_date

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateLeaveRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :leave_records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :leave_of_absence_start_date, null: false
      t.date :leave_of_absence_end_date
      t.string :reason

      t.timestamps
    end
  end
end

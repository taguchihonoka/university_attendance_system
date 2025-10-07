class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.references :user, null: false, foreign_key: true
      t.string :attendance_number, null: false
      t.references :faculty, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.integer :grade, null: false
      t.integer :enrollment_year, null: false
      t.integer :graduation_year, null: false

      t.timestamps
    end
  end
end

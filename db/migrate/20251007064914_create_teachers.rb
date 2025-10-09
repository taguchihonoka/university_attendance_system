class CreateTeachers < ActiveRecord::Migration[8.0]
  def change
    create_table :teachers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :instructor_number, null: false
      t.references :department, null: false, foreign_key: true
      t.references :position, null:false, foreign_key: true
      t.date :assigned_date, null: false
      t.date :retired_date

      t.timestamps
    end
  end
end

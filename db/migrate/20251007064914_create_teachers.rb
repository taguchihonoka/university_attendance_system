class CreateTeachers < ActiveRecord::Migration[8.0]
  def change
    create_table :teachers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :instructor_number, null: false
      t.references :faculty, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.references :position, null:false, foreign_key: true
      t.integer :arrival_year, null: false
      t.integer :retirement_year

      t.timestamps
    end
  end
end

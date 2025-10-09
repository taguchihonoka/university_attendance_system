class CreateDepartmentHistory < ActiveRecord::Migration[8.0]
  def change
    create_table :department_history do |t|
      t.references :user, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.date :started_date, null: false, comment: '所属した日'
      t.date :end_date, comment: '所属から外れた日'

      t.timestamps
    end
  end
end

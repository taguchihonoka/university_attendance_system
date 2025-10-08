class CreateAdmins < ActiveRecord::Migration[8.0]
  def change
    create_table :admins do |t|
      t.references :user, null: false, foreign_key: true
      t.string :admin_number, null: false
      t.date :joined_date, null: false
      t.date :retired_date

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateDepartments < ActiveRecord::Migration[8.0]
  def change
    create_table :departments do |t|
      t.string :name, null: false
      t.references :faculty, null: false, foreign_key: true

      t.timestamps
    end

    add_index :departments, :name, unique: true
  end
end

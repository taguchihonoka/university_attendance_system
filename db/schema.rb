# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_09_052241) do
  create_table "admins", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "admin_number", null: false
    t.date "joined_date", null: false
    t.date "retired_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "department_history", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "department_id", null: false
    t.date "started_date", null: false, comment: "所属した日"
    t.date "end_date", comment: "所属から外れた日"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_department_history_on_department_id"
    t.index ["user_id"], name: "index_department_history_on_user_id"
  end

  create_table "departments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
    t.index ["name"], name: "index_departments_on_name", unique: true
  end

  create_table "faculties", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_faculties_on_name", unique: true
  end

  create_table "leave_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "leave_of_absence_start_date", null: false
    t.date "leave_of_absence_end_date"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leave_records_on_user_id"
  end

  create_table "positions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "students", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "attendance_number", null: false
    t.bigint "department_id", null: false
    t.integer "grade", null: false
    t.date "enrolled_date", null: false
    t.date "graduated_date"
    t.date "dropout_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_students_on_department_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "teachers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "instructor_number", null: false
    t.bigint "department_id", null: false
    t.bigint "position_id", null: false
    t.date "assigned_date", null: false
    t.date "retired_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_teachers_on_department_id"
    t.index ["position_id"], name: "index_teachers_on_position_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "first_name_kana", null: false
    t.string "last_name_kana", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.bigint "role_id", null: false
    t.string "identifier", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["identifier"], name: "index_users_on_identifier", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "admins", "users"
  add_foreign_key "department_history", "departments"
  add_foreign_key "department_history", "users"
  add_foreign_key "departments", "faculties"
  add_foreign_key "leave_records", "users"
  add_foreign_key "students", "departments"
  add_foreign_key "students", "users"
  add_foreign_key "teachers", "departments"
  add_foreign_key "teachers", "positions"
  add_foreign_key "teachers", "users"
  add_foreign_key "users", "roles"
end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# 役割
%w[生徒 講師 管理者].each do |name|
  Role.find_or_create_by!(name: name)
end

# 学部
FACULTY_NAMES =  %w[芸術 文 経済]

FACULTY_NAMES.each do |name|
  Faculty.find_or_create_by!(name: "#{name}学部")
end

# 学科
FACULTY_DEPARTMENTS = {
  '芸術' => %w[美術 工芸],
  '文' => %w[哲学 英文],
  '経済' => %w[経済 経営]
}

FACULTY_DEPARTMENTS.each do |faculty_name, department_names|
  faculty = Faculty.find_by!(name: "#{faculty_name}学部")

  department_names.each do |department_name|
    Department.find_or_create_by!(name: "#{department_name}学科", faculty: faculty)
  end
end

# 職位
POSITION_NAMES = %w[教授 准教授]
  
POSITION_NAMES.each do |position_name|
  Position.find_or_create_by!(name: position_name)
end

# 後にCSV読込で登録するので削除すること
# ユーザー情報
USER_DEFINITIONS = [
  { first_name: '生徒1', email: 'student@com', role: '生徒', identifier: '1251001' },
  { first_name: '講師1', email: 'teacher@com', role: '講師', identifier: '2251001'},
  { first_name: '管理者1', email: 'admin@com', role: '管理者', identifier: '3250001'} ]

USER_DEFINITIONS.each do |user_def|
  role = Role.find_by!(name: user_def[:role])

  user = User.find_or_initialize_by(email: user_def[:email])
  user.first_name = user_def[:first_name]
  user.last_name = 'a'
  user.first_name_kana = 'a'
  user.last_name_kana = 'a'
  user.identifier = user_def[:identifier]
  user.password = 'password'
  user.role = role
  user.save!
end

# 生徒
student_def = { identifier: '1251001', department: '美術学科' } 

user = User.find_by!(identifier: student_def[:identifier])
department = Department.find_by!(name: student_def[:department])

student = Student.find_or_initialize_by(user: user, department: department)
student.user = user
student.attendance_number = '001'
student.department = department
student.grade = '1'
student.enrolled_date = Date.parse('2025-04-01')
student.save!

# 講師
teacher_def = { identifier: '2251001', department: '美術学科', position: '教授' }

user = User.find_by!(identifier: teacher_def[:identifier])
department = Department.find_by!(name: teacher_def[:department])
position = Position.find_by!(name: teacher_def[:position])

teacher = Teacher.find_or_initialize_by(user: user, department: department, position: position)
teacher.user = user
teacher.instructor_number = '001'
teacher.department = department
teacher.position = position
teacher.assigned_date = Date.parse('2025-04-01')
teacher.save!

# 管理者
admin_def = { identifier: '3250001'}

user = User.find_by!(identifier: admin_def[:identifier])

admin = Admin.find_or_initialize_by(user: user)
admin.user = user
admin.admin_number = 001
admin.joined_date = Date.parse('2025-04-01')
admin.save!

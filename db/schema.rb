# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_230_926_032_824) do
  create_table 'admins', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admins_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admins_on_reset_password_token', unique: true
  end

  create_table 'courses', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'name'
    t.bigint 'teacher_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['teacher_id'], name: 'index_courses_on_teacher_id'
  end

  create_table 'customers', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'first_name'
    t.string 'last_name'
    t.index ['email'], name: 'index_customers_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_customers_on_reset_password_token', unique: true
  end

  create_table 'grades', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.integer 'subject'
    t.integer 'score'
    t.integer 'semester'
    t.text 'commest'
    t.bigint 'student_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.index ['deleted_at'], name: 'index_grades_on_deleted_at'
    t.index ['student_id'], name: 'index_grades_on_student_id'
  end

  create_table 'media', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'student_id', null: false
    t.string 'video'
    t.string 'audio'
    t.string 'avatar'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.index ['deleted_at'], name: 'index_media_on_deleted_at'
    t.index ['student_id'], name: 'index_media_on_student_id'
  end

  create_table 'schools', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'deleted_at'
    t.index ['deleted_at'], name: 'index_schools_on_deleted_at'
  end

  create_table 'students', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'age'
    t.string 'address'
    t.datetime 'deleted_at'
    t.date 'birthday'
    t.string 'email'
    t.integer 'position'
    t.string 'first_name'
    t.string 'last_name'
    t.bigint 'school_id'
    t.index ['deleted_at'], name: 'index_students_on_deleted_at'
    t.index ['school_id'], name: 'index_students_on_school_id'
  end

  create_table 'teachers', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'name'
    t.integer 'age'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'school_id'
    t.integer 'position'
    t.datetime 'deleted_at'
    t.index ['deleted_at'], name: 'index_teachers_on_deleted_at'
    t.index ['school_id'], name: 'index_teachers_on_school_id'
  end

  add_foreign_key 'courses', 'teachers'
  add_foreign_key 'grades', 'students'
  add_foreign_key 'media', 'students'
  add_foreign_key 'students', 'schools'
  add_foreign_key 'teachers', 'schools'
end

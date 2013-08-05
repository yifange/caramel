# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130805152322) do

  create_table "assignments", force: true do |t|
    t.integer  "teacher_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["program_id"], name: "index_assignments_on_program_id"
  add_index "assignments", ["teacher_id"], name: "index_assignments_on_teacher_id"

  create_table "attendance_markings", force: true do |t|
    t.string   "abbrev"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", force: true do |t|
    t.integer  "roster_id"
    t.date     "date"
    t.integer  "attendance_marking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["attendance_marking_id"], name: "index_attendances_on_attendance_marking_id"
  add_index "attendances", ["roster_id"], name: "index_attendances_on_roster_id"

  create_table "calendars", force: true do |t|
    t.date     "date"
    t.integer  "term_id"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "school_id"
    t.boolean  "available"
    t.integer  "day_of_week"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calendars", ["school_id"], name: "index_calendars_on_school_id"
  add_index "calendars", ["term_id"], name: "index_calendars_on_term_id"

  create_table "courses", force: true do |t|
    t.integer  "program_id"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "day_of_week"
    t.date     "date"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["program_id"], name: "index_courses_on_program_id"

  create_table "enrollments", force: true do |t|
    t.integer  "student_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["program_id"], name: "index_enrollments_on_program_id"
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id"

  create_table "month_events", force: true do |t|
    t.datetime "date"
    t.string   "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.integer  "school_id"
    t.integer  "instrument_id"
    t.integer  "program_type_id"
    t.integer  "term_id"
    t.integer  "annual_regular_total"
    t.string   "annaul_group_total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programs", ["instrument_id"], name: "index_programs_on_instrument_id"
  add_index "programs", ["program_type_id"], name: "index_programs_on_program_type_id"
  add_index "programs", ["school_id"], name: "index_programs_on_school_id"
  add_index "programs", ["term_id"], name: "index_programs_on_term_id"

  create_table "rosters", force: true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "enrollment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rosters", ["course_id"], name: "index_rosters_on_course_id"
  add_index "rosters", ["enrollment_id"], name: "index_rosters_on_enrollment_id"
  add_index "rosters", ["student_id"], name: "index_rosters_on_student_id"

  create_table "schools", force: true do |t|
    t.string   "abbrev"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "crypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

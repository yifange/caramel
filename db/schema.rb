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

ActiveRecord::Schema.define(version: 20130810025153) do

  create_table "admins", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "attendences", force: true do |t|
    t.integer  "enrollment_id"
    t.date     "date"
    t.integer  "attendence_marking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendences", ["attendence_marking_id"], name: "index_attendences_on_attendence_marking_id"
  add_index "attendences", ["enrollment_id"], name: "index_attendences_on_enrollment_id"

  create_table "calendar_markings", force: true do |t|
    t.string   "abbrev"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "course_types", force: true do |t|
    t.string   "abbrev"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.integer  "program_id"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "day_of_week"
    t.date     "date"
    t.string   "course_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["program_id"], name: "index_courses_on_program_id"

  create_table "domains", force: true do |t|
    t.integer  "user_id"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["region_id"], name: "index_domains_on_region_id"
  add_index "domains", ["user_id"], name: "index_domains_on_user_id"

  create_table "enrollments", force: true do |t|
    t.integer  "student_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["program_id"], name: "index_enrollments_on_program_id"
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id"

  create_table "instruments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "month_events", force: true do |t|
    t.datetime "date"
    t.string   "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "program_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.integer  "school_id"
    t.integer  "instrument_id"
    t.integer  "program_type_id"
    t.integer  "term_id"
    t.integer  "regular_courses_per_year"
    t.string   "group_courses_per_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programs", ["instrument_id"], name: "index_programs_on_instrument_id"
  add_index "programs", ["program_type_id"], name: "index_programs_on_program_type_id"
  add_index "programs", ["school_id"], name: "index_programs_on_school_id"
  add_index "programs", ["term_id"], name: "index_programs_on_term_id"

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "region_id"
    t.string   "abbrev"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["region_id"], name: "index_schools_on_region_id"

  create_table "staffs", force: true do |t|
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

  create_table "teachers", force: true do |t|
  end

  create_table "terms", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                        null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "type"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

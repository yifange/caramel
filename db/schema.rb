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

ActiveRecord::Schema.define(version: 20130709025155) do

  create_table "attendence_markings", force: true do |t|
    t.string   "abbrev"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "school_id"
    t.integer  "calendar_marking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calendars", ["calendar_marking_id"], name: "index_calendars_on_calendar_marking_id"
  add_index "calendars", ["school_id"], name: "index_calendars_on_school_id"

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
    t.string   "day_of_week"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["program_id"], name: "index_courses_on_program_id"

  create_table "enrollments", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "course_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["course_id"], name: "index_enrollments_on_course_id"
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id"

  create_table "instruments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.integer  "school_id"
    t.integer  "instrument_id"
    t.integer  "course_type_id"
    t.string   "regular_courses_per_week"
    t.string   "group_courses_per_month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "programs", ["course_type_id"], name: "index_programs_on_course_type_id"
  add_index "programs", ["instrument_id"], name: "index_programs_on_instrument_id"
  add_index "programs", ["school_id"], name: "index_programs_on_school_id"

  create_table "registrations", force: true do |t|
    t.integer  "program_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "abbrev"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

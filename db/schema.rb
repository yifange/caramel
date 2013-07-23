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

ActiveRecord::Schema.define(version: 20130723014410) do

  create_table "calendar_markings", force: true do |t|
    t.string   "abbrev"
    t.string   "full"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "calendars", force: true do |t|
    t.date     "date"
    t.integer  "calendar_marking_id"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "calendars", ["calendar_marking_id"], name: "index_calendars_on_calendar_marking_id"
  add_index "calendars", ["school_id"], name: "index_calendars_on_school_id"

  create_table "events", force: true do |t|
    t.time     "start_time"
    t.time     "end_time"
    t.date     "date"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "month_events", force: true do |t|
    t.datetime "date"
    t.string   "mark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

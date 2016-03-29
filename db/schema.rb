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

ActiveRecord::Schema.define(version: 20160329162350) do

  create_table "bus_line_bus_stops", force: :cascade do |t|
    t.integer  "bus_line_id"
    t.integer  "bus_stop_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bus_lines", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bus_stops", force: :cascade do |t|
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "lng"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id"
  end

  create_table "errands", force: :cascade do |t|
    t.string   "choice"
    t.integer  "user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "check_start_time"
    t.datetime "check_end_time"
    t.boolean  "done",             default: false
    t.decimal  "start_lat"
    t.decimal  "end_lat"
    t.decimal  "end_lng"
    t.decimal  "start_lng"
    t.decimal  "check_start_lat"
    t.decimal  "check_start_lng"
    t.decimal  "check_end_lat"
    t.decimal  "check_end_lng"
    t.string   "geocoded_start"
    t.string   "geocoded_end"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "lng"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "metro_line_metro_stops", force: :cascade do |t|
    t.integer  "metro_line_id"
    t.integer  "metro_stop_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "metro_lines", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metro_stops", force: :cascade do |t|
    t.string   "name"
    t.decimal  "lat"
    t.decimal  "lng"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",           default: false
    t.datetime "activated_at"
    t.integer  "score_time",          default: 0
    t.integer  "score_money",         default: 0
    t.integer  "score_pollution",     default: 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "pretest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end

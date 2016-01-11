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

ActiveRecord::Schema.define(version: 20160110082409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "intakes", force: :cascade do |t|
    t.string   "intake_code"
    t.integer  "duration"
    t.date     "starting_date"
    t.float    "local_student_fee"
    t.float    "international_student_fee"
    t.integer  "programme_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "programmes", force: :cascade do |t|
    t.string   "programme_type"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "staff_number"
    t.string   "student_number"
    t.string   "contact_number"
    t.string   "intake"
    t.boolean  "international"
    t.string   "type"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end

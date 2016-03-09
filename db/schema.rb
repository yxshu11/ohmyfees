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

ActiveRecord::Schema.define(version: 20160304012625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fines", force: :cascade do |t|
    t.string   "name"
    t.float    "amount"
    t.integer  "student_fee_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "fines", ["student_fee_id"], name: "index_fines_on_student_fee_id", using: :btree

  create_table "intakes", force: :cascade do |t|
    t.string   "intake_code"
    t.date     "starting_date"
    t.float    "local_student_fee"
    t.float    "international_student_fee"
    t.integer  "programme_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "intakes", ["programme_id"], name: "index_intakes_on_programme_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "ip"
    t.string   "express_token"
    t.string   "express_payer_id"
    t.float    "amount"
    t.string   "paid_by"
    t.string   "payment_method"
    t.integer  "student_fee_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "payments", ["student_fee_id"], name: "index_payments_on_student_fee_id", using: :btree

  create_table "programmes", force: :cascade do |t|
    t.string   "programme_type"
    t.string   "name"
    t.integer  "year"
    t.integer  "semester"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "student_fees", force: :cascade do |t|
    t.string   "name"
    t.float    "amount"
    t.date     "due_date"
    t.text     "description"
    t.boolean  "paid",        default: false
    t.datetime "notify"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "student_fees", ["user_id"], name: "index_student_fees_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "staff_number"
    t.string   "student_number"
    t.string   "contact_number"
    t.string   "intake"
    t.boolean  "international"
    t.string   "type"
    t.string   "picture"
    t.boolean  "tfa"
    t.string   "otp_secret_key"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "utility_fees", force: :cascade do |t|
    t.string   "name"
    t.float    "amount"
    t.text     "description"
    t.boolean  "repetitive_payment"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end

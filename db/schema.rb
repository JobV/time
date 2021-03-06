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

ActiveRecord::Schema.define(version: 20140127191236) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "clients", force: true do |t|
    t.string   "company_name"
    t.text     "contact_person"
    t.string   "kvk"
    t.string   "address"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.integer  "uninvoiced"
    t.integer  "uninvoiced_time"
    t.integer  "invoiced"
    t.integer  "invoiced_time"
    t.integer  "paid"
    t.integer  "paid_time"
  end

  create_table "clients_users", id: false, force: true do |t|
    t.integer "client_id"
    t.integer "user_id"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hourly_rate"
    t.integer  "client_id"
    t.integer  "uninvoiced"
    t.integer  "uninvoiced_time"
    t.integer  "invoiced"
    t.integer  "invoiced_time"
    t.integer  "paid"
    t.integer  "paid_time"
  end

  create_table "projects_users", id: false, force: true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "timers", force: true do |t|
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_time"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "total_value"
    t.datetime "start_time"
    t.string   "activity"
    t.datetime "invoiced_at"
    t.datetime "paid_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

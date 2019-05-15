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

ActiveRecord::Schema.define(version: 2019_05_15_010614) do

  create_table "rentals", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "return_date"
    t.integer "user_id"
    t.integer "tool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "return", default: false
    t.datetime "actual_return_date"
    t.boolean "picked_up"
    t.boolean "returned"
    t.index ["tool_id"], name: "index_rentals_on_tool_id"
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name"
    t.string "brand"
    t.string "description"
    t.string "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.integer "rental_price"
    t.string "image"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end

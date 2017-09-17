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

ActiveRecord::Schema.define(version: 20170917050140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "external_id"
    t.string "kind"
    t.string "payment_system"
    t.datetime "synced_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "days", force: :cascade do |t|
    t.date "date"
    t.integer "limit_amount_cents", default: 0, null: false
    t.string "limit_amount_currency", default: "RUB", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date", "user_id"], name: "index_days_on_date_and_user_id", unique: true
    t.index ["user_id"], name: "index_days_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "RUB", null: false
    t.datetime "spend_at"
    t.string "type"
    t.bigint "user_id"
    t.bigint "label_id"
    t.bigint "day_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_expenses_on_day_id"
    t.index ["label_id"], name: "index_expenses_on_label_id"
    t.index ["spend_at"], name: "index_expenses_on_spend_at"
    t.index ["type"], name: "index_expenses_on_type"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "label_id"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "RUB", null: false
    t.datetime "received_at"
    t.datetime "spend_till"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_incomes_on_label_id"
    t.index ["received_at", "spend_till"], name: "index_incomes_on_received_at_and_spend_till"
    t.index ["user_id"], name: "index_incomes_on_user_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "type"
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "assistent"
  end

  add_foreign_key "cards", "users"
  add_foreign_key "days", "users"
  add_foreign_key "expenses", "days"
  add_foreign_key "expenses", "labels"
  add_foreign_key "expenses", "users"
  add_foreign_key "incomes", "labels"
  add_foreign_key "incomes", "users"
  add_foreign_key "labels", "users"
end

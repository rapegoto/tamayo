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

ActiveRecord::Schema.define(version: 20150910150208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: :cascade do |t|
    t.string   "name"
    t.integer  "timeframe"
    t.integer  "price"
    t.integer  "game_session_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "contracts", ["game_session_id"], name: "index_contracts_on_game_session_id", using: :btree

  create_table "day_results", force: :cascade do |t|
    t.integer  "cash"
    t.integer  "day"
    t.integer  "enterprise_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "day_results", ["enterprise_id"], name: "index_day_results_on_enterprise_id", using: :btree

  create_table "enterprises", force: :cascade do |t|
    t.string   "name"
    t.integer  "game_session_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "current_backlog"
    t.integer  "current_cash"
    t.integer  "current_day"
    t.integer  "current_employees"
    t.integer  "current_prod_capacity"
    t.integer  "current_to_produce"
    t.integer  "est_manufactured_today"
    t.integer  "est_delivery_time"
    t.integer  "current_salaries"
    t.integer  "current_raw_materials"
    t.integer  "current_cost_hiring_firing"
    t.integer  "current_contract_id"
    t.integer  "est_total_sales_today"
    t.integer  "est_net_result_today"
    t.integer  "est_new_cash"
    t.integer  "est_new_backlog"
  end

  add_index "enterprises", ["game_session_id"], name: "index_enterprises_on_game_session_id", using: :btree

  create_table "game_decisions", force: :cascade do |t|
    t.integer  "day_of_decision"
    t.integer  "employees_variation"
    t.integer  "enterprise_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "new_contract_id"
  end

  add_index "game_decisions", ["enterprise_id"], name: "index_game_decisions_on_enterprise_id", using: :btree
  add_index "game_decisions", ["new_contract_id"], name: "index_game_decisions_on_new_contract_id", using: :btree

  create_table "game_sessions", force: :cascade do |t|
    t.integer  "virtual_duration"
    t.integer  "real_duration"
    t.integer  "initial_amount_of_cash"
    t.integer  "initial_number_of_employees"
    t.integer  "salary_per_employee"
    t.integer  "hiring_cost"
    t.integer  "firing_cost"
    t.integer  "productivity_per_employee"
    t.integer  "material_cost"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "name"
    t.integer  "current_day"
    t.integer  "initial_backlog"
    t.integer  "orders",                      default: [],              array: true
  end

  add_foreign_key "contracts", "game_sessions"
  add_foreign_key "day_results", "enterprises"
  add_foreign_key "enterprises", "game_sessions"
  add_foreign_key "game_decisions", "contracts", column: "new_contract_id"
  add_foreign_key "game_decisions", "enterprises"
end

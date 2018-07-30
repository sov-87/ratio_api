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

ActiveRecord::Schema.define(version: 2018_07_30_124501) do

  create_table "avg_day_ratios", force: :cascade do |t|
    t.integer "from_currency_id"
    t.integer "to_currency_id"
    t.decimal "buy"
    t.decimal "sell"
    t.datetime "day"
    t.index ["from_currency_id"], name: "index_avg_day_ratios_on_from_currency_id"
    t.index ["to_currency_id"], name: "index_avg_day_ratios_on_to_currency_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "human_name"
    t.string "name"
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratios", force: :cascade do |t|
    t.integer "from_currency_id"
    t.integer "to_currency_id"
    t.decimal "buy"
    t.decimal "sell"
    t.datetime "ts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_currency_id"], name: "index_ratios_on_from_currency_id"
    t.index ["to_currency_id"], name: "index_ratios_on_to_currency_id"
  end

end

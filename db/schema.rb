# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_08_145834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "coins", force: :cascade do |t|
    t.string "coingecko_id"
    t.string "symbol"
    t.string "name"
    t.float "price"
    t.float "price_change_24h"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coingecko_id"], name: "index_coins_on_coingecko_id", unique: true
  end

  create_table "pool_hourlies", force: :cascade do |t|
    t.integer "pool_id"
    t.integer "portfolio_id"
    t.float "current_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pools", force: :cascade do |t|
    t.string "tokens", default: [], array: true
    t.string "name"
    t.string "pool_owner"
    t.float "current_price"
    t.float "initial_capital"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer "user_id"
    t.string "terra_address"
    t.string "fantom_address"
    t.string "osmosis_address"
    t.text "ref_finance_shares"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end

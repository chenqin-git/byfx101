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

ActiveRecord::Schema.define(version: 20170214121545) do

  create_table "account_books", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount",               precision: 8, scale: 2
    t.integer  "transaction_type"
    t.integer  "order_id"
    t.string   "deposit_reference_no"
    t.string   "operator"
    t.string   "remark"
    t.decimal  "balance",              precision: 8, scale: 2
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.index ["user_id"], name: "index_account_books_on_user_id"
  end

  create_table "agent_ranks", force: :cascade do |t|
    t.string   "name"
    t.integer  "rank"
    t.string   "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_results", force: :cascade do |t|
    t.string   "result"
    t.string   "message"
    t.string   "operator"
    t.integer  "order_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "success_num"
    t.index ["order_id"], name: "index_order_results_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "num"
    t.string   "input"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "state",         default: 0
    t.string   "serial_number"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "remark"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "input_name"
  end

  create_table "project_relationships", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "quotations", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "agent_rank_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.decimal  "price",         precision: 8, scale: 2
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "agent_rank_id",          default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

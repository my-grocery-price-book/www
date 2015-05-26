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

ActiveRecord::Schema.define(version: 20150526162500) do

  create_table "purchase_items", force: :cascade do |t|
    t.integer  "purchase_id",        null: false
    t.string   "product_brand_name", null: false
    t.string   "generic_name",       null: false
    t.string   "package_type",       null: false
    t.decimal  "package_size",       null: false
    t.string   "package_unit",       null: false
    t.decimal  "quanity",            null: false
    t.decimal  "total_price",        null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "purchase_items", ["purchase_id"], name: "index_purchase_items_on_purchase_id"

  create_table "purchases", force: :cascade do |t|
    t.date     "purchased_on"
    t.string   "store"
    t.string   "location"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "shopper_id"
  end

  add_index "purchases", ["shopper_id"], name: "index_purchases_on_shopper_id"

  create_table "shoppers", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "shoppers", ["confirmation_token"], name: "index_shoppers_on_confirmation_token", unique: true
  add_index "shoppers", ["email"], name: "index_shoppers_on_email", unique: true
  add_index "shoppers", ["reset_password_token"], name: "index_shoppers_on_reset_password_token", unique: true

end

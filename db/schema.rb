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

ActiveRecord::Schema.define(version: 20160420201023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comfy_cms_blocks", force: :cascade do |t|
    t.string   "identifier",     null: false
    t.text     "content"
    t.integer  "blockable_id"
    t.string   "blockable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_blocks", ["blockable_id", "blockable_type"], name: "index_comfy_cms_blocks_on_blockable_id_and_blockable_type", using: :btree
  add_index "comfy_cms_blocks", ["identifier"], name: "index_comfy_cms_blocks_on_identifier", using: :btree

  create_table "comfy_cms_categories", force: :cascade do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "comfy_cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true, using: :btree

  create_table "comfy_cms_categorizations", force: :cascade do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "comfy_cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "comfy_cms_files", force: :cascade do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_files", ["site_id", "block_id"], name: "index_comfy_cms_files_on_site_id_and_block_id", using: :btree
  add_index "comfy_cms_files", ["site_id", "file_file_name"], name: "index_comfy_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "comfy_cms_files", ["site_id", "label"], name: "index_comfy_cms_files_on_site_id_and_label", using: :btree
  add_index "comfy_cms_files", ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position", using: :btree

  create_table "comfy_cms_layouts", force: :cascade do |t|
    t.integer  "site_id",                    null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.text     "css"
    t.text     "js"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_layouts", ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_layouts", ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "comfy_cms_pages", force: :cascade do |t|
    t.integer  "site_id",                        null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                          null: false
    t.string   "slug"
    t.string   "full_path",                      null: false
    t.text     "content_cache"
    t.integer  "position",       default: 0,     null: false
    t.integer  "children_count", default: 0,     null: false
    t.boolean  "is_published",   default: true,  null: false
    t.boolean  "is_shared",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_pages", ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_pages", ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "comfy_cms_revisions", force: :cascade do |t|
    t.string   "record_type", null: false
    t.integer  "record_id",   null: false
    t.text     "data"
    t.datetime "created_at"
  end

  add_index "comfy_cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at", using: :btree

  create_table "comfy_cms_sites", force: :cascade do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "comfy_cms_sites", ["hostname"], name: "index_comfy_cms_sites_on_hostname", using: :btree
  add_index "comfy_cms_sites", ["is_mirrored"], name: "index_comfy_cms_sites_on_is_mirrored", using: :btree

  create_table "comfy_cms_snippets", force: :cascade do |t|
    t.integer  "site_id",                    null: false
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_snippets", ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "comfy_cms_snippets", ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position", using: :btree

  create_table "invites", force: :cascade do |t|
    t.integer  "price_book_id"
    t.string   "name"
    t.string   "email"
    t.string   "status",        default: "sent", null: false
    t.string   "token",                          null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "invites", ["price_book_id"], name: "index_invites_on_price_book_id", using: :btree
  add_index "invites", ["token"], name: "index_invites_on_token", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "price_book_id"
    t.integer  "shopper_id"
    t.boolean  "admin",         default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "members", ["price_book_id"], name: "index_members_on_price_book_id", using: :btree
  add_index "members", ["shopper_id"], name: "index_members_on_shopper_id", using: :btree

  create_table "price_book_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "product_names", default: [],              array: true
    t.string   "unit"
    t.integer  "price_book_id"
  end

  add_index "price_book_pages", ["price_book_id"], name: "index_price_book_pages_on_price_book_id", using: :btree

  create_table "price_books", force: :cascade do |t|
    t.integer  "_deprecated_shopper_id"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "name",                            default: "My Price Book", null: false
    t.boolean  "_deprecated_shopper_id_migrated", default: false,           null: false
  end

  add_index "price_books", ["_deprecated_shopper_id"], name: "index_price_books_on__deprecated_shopper_id", using: :btree

  create_table "purchase_items", force: :cascade do |t|
    t.integer  "purchase_id"
    t.string   "product_brand_name"
    t.decimal  "package_size"
    t.string   "package_unit"
    t.integer  "quantity"
    t.decimal  "total_price"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "category"
    t.string   "regular_name"
  end

  add_index "purchase_items", ["purchase_id"], name: "index_purchase_items_on_purchase_id", using: :btree

  create_table "purchases", force: :cascade do |t|
    t.date     "purchased_on"
    t.string   "store"
    t.string   "location"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "shopper_id"
    t.datetime "completed_at"
  end

  add_index "purchases", ["shopper_id"], name: "index_purchases_on_shopper_id", using: :btree

  create_table "shopper_api_keys", force: :cascade do |t|
    t.integer  "shopper_id", null: false
    t.string   "api_key",    null: false
    t.string   "api_root",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shoppers", force: :cascade do |t|
    t.string   "email",                  default: "",                                          null: false
    t.string   "encrypted_password",     default: "",                                          null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                                           null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
    t.string   "current_public_api",     default: "za-wc.public-grocery-price-book-api.co.za", null: false
    t.boolean  "guest",                  default: false,                                       null: false
  end

  add_index "shoppers", ["confirmation_token"], name: "index_shoppers_on_confirmation_token", unique: true, using: :btree
  add_index "shoppers", ["email"], name: "index_shoppers_on_email", using: :btree
  add_index "shoppers", ["reset_password_token"], name: "index_shoppers_on_reset_password_token", unique: true, using: :btree

  create_table "shopping_list_item_purchases", force: :cascade do |t|
    t.integer  "shopping_list_item_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "shopping_list_item_purchases", ["shopping_list_item_id"], name: "index_shopping_list_item_purchases_on_shopping_list_item_id", using: :btree

  create_table "shopping_list_items", force: :cascade do |t|
    t.integer  "shopping_list_id"
    t.string   "name"
    t.integer  "amount"
    t.string   "unit"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "shopping_list_items", ["created_at"], name: "index_shopping_list_items_on_created_at", using: :btree

  create_table "shopping_lists", force: :cascade do |t|
    t.integer  "_deprecated_shopper_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "title"
    t.integer  "price_book_id"
    t.boolean  "_deprecated_shopper_id_migrated", default: false, null: false
  end

  add_index "shopping_lists", ["_deprecated_shopper_id"], name: "index_shopping_lists_on__deprecated_shopper_id", using: :btree
  add_index "shopping_lists", ["price_book_id"], name: "index_shopping_lists_on_price_book_id", using: :btree

  add_foreign_key "invites", "price_books"
  add_foreign_key "members", "price_books"
  add_foreign_key "members", "shoppers"
  add_foreign_key "price_book_pages", "price_books"
  add_foreign_key "shopping_list_item_purchases", "shopping_list_items"
  add_foreign_key "shopping_lists", "price_books"
end

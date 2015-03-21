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

ActiveRecord::Schema.define(version: 20150320211659) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "label"
    t.string   "street"
    t.string   "street2"
    t.string   "street3"
    t.string   "number"
    t.string   "care_of"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "has_address_type"
    t.integer  "has_address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_infos", force: :cascade do |t|
    t.string  "phone"
    t.string  "phone2"
    t.string  "phone3"
    t.string  "main_email"
    t.string  "billing_email"
    t.string  "website_url"
    t.integer "has_contact_info_id"
    t.string  "has_contact_info_type"
  end

  create_table "farm_notes", force: :cascade do |t|
    t.integer  "has_farm_notes_id"
    t.string   "has_farm_notes_type"
    t.text     "content"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "farm_store_items", force: :cascade do |t|
    t.string   "name"
    t.text     "pricing"
    t.text     "description"
    t.float    "tax_rate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "farm_store_orders", force: :cascade do |t|
    t.text     "items"
    t.integer  "makes_orders_id"
    t.string   "makes_orders_type"
    t.string   "phase"
    t.text     "billing_address"
    t.text     "shipping_address"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "news_stories", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "published",                default: false
    t.boolean  "archived",                 default: false
    t.string   "main_news_story_image"
    t.string   "writes_news_stories_type"
    t.string   "writes_news_stories_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "slug"
  end

  create_table "social_networking_profiles", force: :cascade do |t|
    t.string   "facebook_app_id"
    t.string   "facebook_app_secret"
    t.string   "facebook_id"
    t.string   "twitter_app_id"
    t.string   "twitter_id"
    t.string   "has_social_networking_id"
    t.string   "has_social_networking_type"
    t.string   "tumblr_id"
    t.string   "google_plus_id"
    t.string   "pinterest_id"
    t.string   "instagram_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "leafly_app_id"
    t.string   "leafly_app_key"
  end

  create_table "stores", force: :cascade do |t|
    t.string   "tax_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

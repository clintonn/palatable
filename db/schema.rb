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

ActiveRecord::Schema.define(version: 20170112005653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "foursquare_id"
    t.string   "url"
    t.string   "phone"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "menu"
    t.string   "photo"
    t.integer  "price_tier"
    t.datetime "last_updated"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "content"
    t.integer  "food_rating"
    t.integer  "environment_rating"
    t.integer  "service_rating"
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.decimal  "avg_rating"
    t.string   "title"
  end

  create_table "searches", force: :cascade do |t|
    t.string "query"
    t.string "search"
    t.string "location"
  end

  create_table "upvotes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end

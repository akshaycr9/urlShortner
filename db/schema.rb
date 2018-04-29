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

ActiveRecord::Schema.define(version: 20180429061836) do

  create_table "url_statistics", force: :cascade do |t|
    t.integer  "same_url_converted",     default: 0
    t.integer  "url_opened",             default: 0
    t.datetime "last_opened_at"
    t.string   "last_browser_opened_on"
    t.integer  "url_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "urls", force: :cascade do |t|
    t.string   "original_url"
    t.string   "converted_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "formatted_url"
    t.string   "protocol"
  end

end

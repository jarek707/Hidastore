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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120309185916) do

  create_table "fields", :force => true do |t|
    t.string   "dom"
    t.string   "flags"
    t.string   "xml"
    t.integer  "plug_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "label"
  end

  add_index "fields", ["plug_id"], :name => "index_fields_on_plug_id"

  create_table "groups", :force => true do |t|
    t.string   "desc"
    t.string   "hex_val"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plugs", :force => true do |t|
    t.string   "tab_name"
    t.string   "flags"
    t.string   "legend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "phone"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["group_id"], :name => "index_users_on_group_id"

end

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

ActiveRecord::Schema.define(:version => 20120307081254) do

  create_table "datasets", :force => true do |t|
    t.string   "tbl"
    t.integer  "pid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fields", :force => true do |t|
    t.string   "dom_id"
    t.string   "xml_id"
    t.string   "label"
    t.integer  "valid_id"
    t.integer  "vis_id"
    t.integer  "dataset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fields", ["dataset_id"], :name => "index_fields_on_dataset_id"
  add_index "fields", ["valid_id"], :name => "index_fields_on_valid_id"
  add_index "fields", ["vis_id"], :name => "index_fields_on_vis_id"

  create_table "groups", :force => true do |t|
    t.string   "desc"
    t.string   "hex_val"
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

  create_table "vailds", :force => true do |t|
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

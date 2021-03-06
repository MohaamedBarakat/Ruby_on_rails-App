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

ActiveRecord::Schema.define(version: 20220420224652) do

  create_table "applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "token",                  null: false
    t.integer  "chat_count", default: 0, null: false
    t.string   "name",                   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["token"], name: "index_applications_on_token", unique: true, using: :btree
  end

  create_table "chats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint   "number",                               null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "application_id",                       null: false
    t.string   "name",           default: "chat name", null: false
    t.integer  "messages_count", default: 0,           null: false
    t.index ["application_id"], name: "index_chats_on_application_id", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint   "number",                   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "chats_id",                 null: false
    t.text     "body",       limit: 65535, null: false
    t.index ["chats_id"], name: "index_messages_on_chats_id", using: :btree
  end

  add_foreign_key "chats", "applications"
  add_foreign_key "messages", "chats", column: "chats_id"
end

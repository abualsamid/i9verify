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

ActiveRecord::Schema.define(:version => 20120908000349) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "task_id"
  end

  add_index "microposts", ["task_id"], :name => "index_microposts_on_task_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stacks", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.integer  "user_id"
    t.integer  "company_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "slug",       :default => "", :null => false
  end

  add_index "stacks", ["company_id"], :name => "index_stacks_on_company_id"
  add_index "stacks", ["user_id", "slug"], :name => "index_stacks_on_user_id_and_slug", :unique => true
  add_index "stacks", ["user_id"], :name => "index_stacks_on_user_id"

  create_table "status", :force => true do |t|
    t.string   "name",       :default => "",   :null => false
    t.integer  "sequence",   :default => 999,  :null => false
    t.boolean  "isActive",   :default => true, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "company_id",                  :null => false
    t.integer  "user_id",                     :null => false
    t.integer  "stack_id",                    :null => false
    t.string   "name",        :default => "", :null => false
    t.text     "description",                 :null => false
    t.datetime "due"
    t.integer  "status_id",   :default => 0,  :null => false
    t.integer  "priority",    :default => 1,  :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.time     "duetime"
  end

  add_index "tasks", ["company_id", "user_id"], :name => "index_tasks_on_company_id_and_user_id"
  add_index "tasks", ["stack_id"], :name => "index_tasks_on_stack_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "teams", ["user_id", "name"], :name => "index_teams_on_user_id_and_name", :unique => true
  add_index "teams", ["user_id"], :name => "index_teams_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.boolean  "admin",           :default => false
    t.integer  "company_id",      :default => 0,     :null => false
  end

  add_index "users", ["company_id"], :name => "index_users_on_company_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end

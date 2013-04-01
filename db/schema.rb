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

ActiveRecord::Schema.define(:version => 20130401060648) do

  create_table "classifieds", :id => false, :force => true do |t|
    t.integer  "mid",        :default => 0, :null => false
    t.integer  "gid",        :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "classifieds", ["gid"], :name => "gid"

  create_table "genres", :force => true do |t|
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "genres", ["category"], :name => "name", :unique => true

  create_table "m_nominated", :id => false, :force => true do |t|
    t.integer  "oid",        :default => 0, :null => false
    t.integer  "mid",        :default => 0, :null => false
    t.integer  "year",       :default => 0, :null => false
    t.boolean  "win"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "m_nominated", ["mid"], :name => "mid"

  create_table "movies", :force => true do |t|
    t.string   "name"
    t.datetime "release_date"
    t.float    "imdb_rating"
    t.integer  "length"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "movies", ["name", "release_date"], :name => "name_date_constraint", :unique => true

  create_table "oscars", :force => true do |t|
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "oscars", ["category"], :name => "category_constraint", :unique => true

  create_table "p_nominated", :id => false, :force => true do |t|
    t.integer  "oid",        :default => 0, :null => false
    t.integer  "pid",        :default => 0, :null => false
    t.integer  "mid",        :default => 0, :null => false
    t.integer  "year",       :default => 0, :null => false
    t.boolean  "win"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "p_nominated", ["mid"], :name => "mid"
  add_index "p_nominated", ["pid"], :name => "pid"

  create_table "persons", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "mname"
    t.datetime "dob"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "persons", ["fname", "mname", "lname"], :name => "persons_unique_constraint", :unique => true

  create_table "ratings", :id => false, :force => true do |t|
    t.integer  "uid",        :default => 0, :null => false
    t.integer  "mid",        :default => 0, :null => false
    t.float    "score"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "ratings", ["mid"], :name => "mid"

  create_table "roles", :id => false, :force => true do |t|
    t.integer  "pid",        :default => 0,  :null => false
    t.integer  "mid",        :default => 0,  :null => false
    t.string   "role_name",  :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "roles", ["mid"], :name => "mid"

  create_table "u_modify", :id => false, :force => true do |t|
    t.integer  "uid",        :default => 0, :null => false
    t.integer  "mid",        :default => 0, :null => false
    t.string   "action"
    t.string   "data"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "u_modify", ["mid"], :name => "mid"

  create_table "users", :force => true do |t|
    t.string   "fname"
    t.string   "mname"
    t.string   "lname"
    t.datetime "dob"
    t.string   "email"
    t.string   "password"
    t.boolean  "is_admin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["email"], :name => "email_constraint", :unique => true

end

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

ActiveRecord::Schema.define(:version => 20130513180307) do

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
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "imdb_url"
    t.string   "poster_url"
    t.text     "plot"
    t.float    "user_rating"
    t.integer  "user_rating_count"
  end

  add_index "movies", ["imdb_rating", "name"], :name => "movie_imdb_index"
  add_index "movies", ["name", "release_date"], :name => "name_date_constraint", :unique => true
  add_index "movies", ["name"], :name => "movie_name_index"
  add_index "movies", ["release_date", "name"], :name => "movie_year_index"
  add_index "movies", ["user_rating"], :name => "u_rating_avg_index"
  add_index "movies", ["user_rating_count"], :name => "u_rating_cnt_index"

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

  create_table "u_ratings", :force => true do |t|
    t.integer  "uid"
    t.integer  "mid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "rating"
  end

  add_index "u_ratings", ["mid"], :name => "fk_mid_u_ratings"


  add_index "u_ratings", ["rating"], :name => "rating_index"

  add_index "u_ratings", ["uid", "mid"], :name => "unique_user_rating", :unique => true
  add_index "u_ratings", ["updated_at"], :name => "updated_at_index"

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

  create_table "users_archive", :id => false, :force => true do |t|
    t.integer  "id"
    t.string   "fname"
    t.string   "mname"
    t.string   "lname"
    t.datetime "dob"
    t.string   "email"
    t.string   "password"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

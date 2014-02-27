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

ActiveRecord::Schema.define(:version => 20140225055501) do

  create_table "comments", :force => true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "links", :force => true do |t|
    t.integer "user_id"
    t.text    "url"
    t.text    "link_id"
    t.text    "sender_name"
    t.text    "sender_id"
    t.text    "message"
    t.text    "name"
    t.text    "caption"
    t.text    "picture_url"
    t.text    "description"
    t.time    "created_time"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "wall_id"
    t.boolean  "revoked",         :default => false
    t.datetime "last_visit_time"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "link"
    t.text     "description"
    t.integer  "vote_count",         :default => 0
    t.string   "video_url"
    t.integer  "user_id"
    t.integer  "wall_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "name",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "oauth_token"
    t.time     "oauth_expires_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "walls", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.string   "description"
    t.string   "access_code"
    t.integer  "admin_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end

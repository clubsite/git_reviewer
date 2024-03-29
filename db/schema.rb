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

ActiveRecord::Schema.define(:version => 20120701091500) do

  create_table "changed_files", :force => true do |t|
    t.integer  "compare_id"
    t.string   "file_name"
    t.string   "sha"
    t.integer  "reviewer_id"
    t.string   "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "changed_files", ["compare_id"], :name => "index_changed_files_on_compare_id"
  add_index "changed_files", ["reviewer_id"], :name => "index_changed_files_on_reviewer_id"
  add_index "changed_files", ["status"], :name => "index_changed_files_on_status"

  create_table "commits", :force => true do |t|
    t.string   "sha"
    t.integer  "repository_id"
    t.string   "author_name"
    t.string   "author_email"
    t.datetime "written_at"
    t.string   "committer_name"
    t.string   "committer_email"
    t.datetime "committed_at"
    t.text     "message"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "reviewer_id"
    t.string   "status",          :default => "open"
  end

  add_index "commits", ["repository_id", "reviewer_id"], :name => "index_commits_on_repository_id_and_reviewer_id"
  add_index "commits", ["repository_id", "sha"], :name => "index_commits_on_repository_id_and_sha"
  add_index "commits", ["repository_id", "status"], :name => "index_commits_on_repository_id_and_status"

  create_table "compares", :force => true do |t|
    t.integer  "repository_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "compares", ["repository_id"], :name => "index_compares_on_repository_id"

  create_table "licenses", :force => true do |t|
    t.string   "name"
    t.string   "homepage"
    t.string   "current_version"
    t.string   "previous_version"
    t.string   "license"
    t.string   "previous_license"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "repositories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.datetime "last_synced_at"
    t.datetime "synced_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

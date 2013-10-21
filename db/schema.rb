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

ActiveRecord::Schema.define(:version => 20131021154242) do

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "pairings", :force => true do |t|
    t.integer  "week_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "week_number"
    t.integer  "organization_id"
  end

  add_index "pairings", ["week_id"], :name => "index_pairings_on_week_id"

  create_table "pairings_people", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "pairing_id"
  end

  add_index "pairings_people", ["pairing_id", "person_id"], :name => "index_pairings_people_on_pairing_id_and_person_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "organization_id"
    t.integer  "paired_count"
    t.integer  "unpaired_count"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "people", ["organization_id"], :name => "index_people_on_organization_id"

  create_table "people_teams", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "team_id"
  end

  add_index "people_teams", ["person_id", "team_id"], :name => "index_people_teams_on_person_id_and_team_id", :unique => true

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "teams", ["organization_id"], :name => "index_teams_on_organization_id"

  create_table "weeks", :force => true do |t|
    t.integer  "week_number"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
  end

end

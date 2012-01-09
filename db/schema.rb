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

ActiveRecord::Schema.define(:version => 20120109194215) do

  create_table "degrees", :force => true do |t|
    t.integer  "university_id"
    t.integer  "person_id"
    t.string   "degree_earned"
    t.date     "year_earned"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "degrees", ["person_id"], :name => "index_degrees_on_person_id"
  add_index "degrees", ["university_id"], :name => "index_degrees_on_university_id"

  create_table "family_members", :force => true do |t|
    t.string   "name"
    t.string   "relationship"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
  end

  add_index "family_members", ["person_id"], :name => "index_family_members_on_person_id"

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.date     "date_of_birth"
    t.date     "date_of_death"
    t.string   "title"
    t.text     "bio"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "professional_experience"
    t.text     "literary_work"
    t.integer  "religion_id"
    t.string   "current_residence"
    t.text     "dates_in_office"
    t.string   "photo_url"
    t.string   "contact_street_address"
    t.string   "contact_city"
    t.string   "contact_state"
    t.integer  "contact_zip"
    t.string   "contact_phone"
    t.string   "contact_fax"
    t.string   "contact_email"
    t.string   "contact_web_page_name"
    t.string   "contact_web_page_url"
    t.integer  "net_worth_ranking"
    t.integer  "net_worth_minimum"
    t.integer  "net_worth_average"
    t.integer  "net_worth_maximum"
    t.integer  "family_members_id"
  end

  create_table "religions", :force => true do |t|
    t.string   "name"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "religions", ["person_id"], :name => "index_religions_on_person_id"

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.integer  "person_id"
    t.integer  "degree_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "universities", ["degree_id"], :name => "index_universities_on_degree_id"
  add_index "universities", ["person_id"], :name => "index_universities_on_person_id"

end

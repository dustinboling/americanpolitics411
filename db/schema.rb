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

ActiveRecord::Schema.define(:version => 20120112222614) do

  create_table "accusations", :force => true do |t|
    t.integer  "person_id"
    t.date     "date"
    t.text     "accusation"
    t.text     "outcome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accusations", ["person_id"], :name => "index_accusations_on_person_id"

  create_table "articles", :force => true do |t|
    t.integer  "person_id"
    t.string   "title"
    t.text     "excerpt"
    t.string   "article_url"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["person_id"], :name => "index_articles_on_person_id"

  create_table "attachments", :force => true do |t|
    t.integer  "article_id"
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_associates", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "person_id"
    t.string   "full_name"
    t.string   "position"
    t.text     "business_relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "business_associates", ["organization_id"], :name => "index_business_associates_on_organization_id"
  add_index "business_associates", ["person_id"], :name => "index_business_associates_on_person_id"

  create_table "campaign_platforms", :force => true do |t|
    t.integer  "person_id"
    t.date     "campaign_year"
    t.string   "topic"
    t.string   "position_on_issue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaign_platforms", ["person_id"], :name => "index_campaign_platforms_on_person_id"

  create_table "contributors", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organization_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contributors", ["organization_id"], :name => "index_contributors_on_organization_id"
  add_index "contributors", ["person_id"], :name => "index_contributors_on_person_id"

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

  create_table "endorsements", :force => true do |t|
    t.integer  "person_id"
    t.date     "year"
    t.string   "organization_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "endorsements", ["person_id"], :name => "index_endorsements_on_person_id"

  create_table "family_members", :force => true do |t|
    t.string   "name"
    t.string   "relationship"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
  end

  add_index "family_members", ["person_id"], :name => "index_family_members_on_person_id"

  create_table "flip_flops", :force => true do |t|
    t.integer  "person_id"
    t.date     "year"
    t.text     "issue"
    t.text     "flipflop"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flip_flops", ["person_id"], :name => "index_flip_flops_on_person_id"

  create_table "litigations", :force => true do |t|
    t.integer  "person_id"
    t.date     "date"
    t.text     "litigation"
    t.text     "outcome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "litigations", ["person_id"], :name => "index_litigations_on_person_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.date     "date_of_birth"
    t.date     "date_of_death"
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

  create_table "personal_assets", :force => true do |t|
    t.integer  "person_id"
    t.string   "organization_name"
    t.boolean  "action"
    t.date     "date"
    t.integer  "value_min"
    t.integer  "value_max"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "personal_assets", ["organization_id"], :name => "index_personal_assets_on_organization_id"
  add_index "personal_assets", ["person_id"], :name => "index_personal_assets_on_person_id"

  create_table "professional_experiences", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organization_id"
    t.string   "position"
    t.date     "date_started"
    t.date     "date_ended"
    t.text     "accomplishments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "professional_experiences", ["organization_id"], :name => "index_professional_experiences_on_organization_id"
  add_index "professional_experiences", ["person_id"], :name => "index_professional_experiences_on_person_id"

  create_table "religions", :force => true do |t|
    t.string   "name"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "religions", ["person_id"], :name => "index_religions_on_person_id"

  create_table "supporters", :force => true do |t|
    t.string   "group_name"
    t.string   "support_percentage"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporters", ["person_id"], :name => "index_supporters_on_person_id"

  create_table "transactions", :force => true do |t|
    t.integer  "person_id"
    t.string   "organization_name"
    t.boolean  "action"
    t.date     "date"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "transactions", ["organization_id"], :name => "index_transactions_on_organization_id"
  add_index "transactions", ["person_id"], :name => "index_transactions_on_person_id"

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.integer  "person_id"
    t.integer  "degree_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "universities", ["degree_id"], :name => "index_universities_on_degree_id"
  add_index "universities", ["person_id"], :name => "index_universities_on_person_id"

  create_table "videos", :force => true do |t|
    t.integer  "person_id"
    t.date     "date"
    t.string   "title"
    t.text     "description"
    t.string   "video_url"
    t.string   "thumbnail_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["person_id"], :name => "index_videos_on_person_id"

end

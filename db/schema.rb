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

ActiveRecord::Schema.define(:version => 20120229191042) do

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

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["role_id"], :name => "index_assignments_on_role_id"
  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"

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

  create_table "committee_assignments", :force => true do |t|
    t.integer  "person_id"
    t.integer  "committee_id"
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "committee_assignments", ["committee_id"], :name => "index_committee_assignments_on_committee_id"
  add_index "committee_assignments", ["person_id"], :name => "index_committee_assignments_on_person_id"

  create_table "committee_legislations", :force => true do |t|
    t.integer  "committee_id"
    t.integer  "legislation_id"
    t.string   "congress_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "year"
  end

  add_index "committee_legislations", ["committee_id"], :name => "index_committee_legislations_on_committee_id"
  add_index "committee_legislations", ["legislation_id"], :name => "index_committee_legislations_on_legislation_id"

  create_table "committees", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "nyt_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contributors", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organization_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contributors", ["organization_id"], :name => "index_contributors_on_organization_id"
  add_index "contributors", ["person_id"], :name => "index_contributors_on_person_id"

  create_table "contributors_interest_group_sectors", :force => true do |t|
    t.integer  "person_id"
    t.string   "name"
    t.integer  "amount"
    t.date     "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "contributors_interest_group_sectors", ["organization_id"], :name => "index_contributors_interest_group_sectors_on_organization_id"
  add_index "contributors_interest_group_sectors", ["person_id"], :name => "index_contributors_interest_group_sectors_on_person_id"

  create_table "contributors_interest_groups", :force => true do |t|
    t.integer  "person_id"
    t.string   "name"
    t.integer  "amount"
    t.date     "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "contributors_interest_groups", ["organization_id"], :name => "index_contributors_interest_groups_on_organization_id"
  add_index "contributors_interest_groups", ["person_id"], :name => "index_contributors_interest_groups_on_person_id"

  create_table "contributors_pacs", :force => true do |t|
    t.integer  "person_id"
    t.string   "name"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "year"
    t.integer  "organization_id"
  end

  add_index "contributors_pacs", ["organization_id"], :name => "index_contributors_pacs_on_organization_id"
  add_index "contributors_pacs", ["person_id"], :name => "index_contributors_pacs_on_person_id"

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

  create_table "earmarks", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organization_id"
    t.text     "description"
    t.string   "sector"
    t.integer  "amount"
    t.date     "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "earmarks", ["organization_id"], :name => "index_earmarks_on_organization_id"
  add_index "earmarks", ["person_id"], :name => "index_earmarks_on_person_id"

  create_table "endorsements", :force => true do |t|
    t.integer  "person_id"
    t.date     "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "endorsements", ["organization_id"], :name => "index_endorsements_on_organization_id"
  add_index "endorsements", ["person_id"], :name => "index_endorsements_on_person_id"

  create_table "family_members", :force => true do |t|
    t.string   "relationship"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.string   "family_member"
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

  create_table "issue_positions", :force => true do |t|
    t.integer  "person_id"
    t.string   "issue_topic"
    t.string   "question"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "issue_positions", ["person_id"], :name => "index_issue_positions_on_person_id"

  create_table "issues", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legislation_cosponsors", :force => true do |t|
    t.integer  "person_id"
    t.integer  "legislation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legislation_cosponsors", ["legislation_id"], :name => "index_legislation_cosponsors_on_legislation_id"
  add_index "legislation_cosponsors", ["person_id"], :name => "index_legislation_cosponsors_on_person_id"

  create_table "legislation_issues", :force => true do |t|
    t.integer  "legislation_id"
    t.integer  "issue_id"
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legislation_issues", ["issue_id"], :name => "index_legislation_issues_on_issue_id"
  add_index "legislation_issues", ["legislation_id"], :name => "index_legislation_issues_on_legislation_id"

  create_table "legislations", :force => true do |t|
    t.string   "bill_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bill_number"
    t.text     "bill_title"
    t.string   "introduced_date"
    t.string   "latest_major_action_date"
    t.text     "latest_major_action"
    t.string   "bill_sponsor"
    t.string   "bill_sponsor_id"
    t.text     "bill_pdf"
    t.string   "congress_year"
    t.string   "republican_cosponsors"
    t.string   "democratic_cosponsors"
  end

  add_index "legislations", ["bill_uri"], :name => "index_legislations_on_bill_uri"

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

  add_index "organizations", ["name"], :name => "index_organizations_on_name", :unique => true

  create_table "organizations_people", :force => true do |t|
    t.integer  "person_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations_people", ["organization_id"], :name => "index_organizations_people_on_organization_id"
  add_index "organizations_people", ["person_id"], :name => "index_organizations_people_on_person_id"

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
    t.integer  "religion_id",             :default => 7, :null => false
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
    t.string   "name"
    t.string   "gender"
    t.string   "times_topics_url"
    t.string   "govtrack_id"
    t.string   "cspan_id"
    t.string   "icpsr_id"
    t.string   "twitter_id"
    t.string   "youtube_id"
    t.string   "current_party"
    t.string   "chamber"
    t.string   "nyt_id"
  end

  create_table "person_videos", :force => true do |t|
    t.integer  "person_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_videos", ["person_id"], :name => "index_person_videos_on_person_id"
  add_index "person_videos", ["video_id"], :name => "index_person_videos_on_video_id"

  create_table "personal_assets", :force => true do |t|
    t.integer  "person_id"
    t.integer  "value_min"
    t.integer  "value_max"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "personal_assets", ["organization_id"], :name => "index_personal_assets_on_organization_id"
  add_index "personal_assets", ["person_id"], :name => "index_personal_assets_on_person_id"

  create_table "political_offices", :force => true do |t|
    t.integer  "person_id"
    t.string   "position"
    t.string   "district"
    t.string   "office"
    t.date     "date_started"
    t.date     "date_finished"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "political_offices", ["person_id"], :name => "index_political_offices_on_person_id"

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

  create_table "relationships", :force => true do |t|
    t.integer  "person_id"
    t.integer  "family_member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "relationship"
  end

  create_table "religions", :force => true do |t|
    t.string   "name"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "religions", ["person_id"], :name => "index_religions_on_person_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsored_legislations", :force => true do |t|
    t.integer  "person_id"
    t.boolean  "sponsor"
    t.string   "bill_number"
    t.date     "year_of_congress"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sponsored_legislations", ["person_id"], :name => "index_sponsored_legislations_on_person_id"

  create_table "supporters", :force => true do |t|
    t.string   "group_name"
    t.string   "support_percentage"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporters", ["person_id"], :name => "index_supporters_on_person_id"

  create_table "tests", :force => true do |t|
    t.string   "test1"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "person_id"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                        :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "roles_mask"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

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

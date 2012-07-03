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

ActiveRecord::Schema.define(:version => 20120703225942) do

  create_table "accusations", :force => true do |t|
    t.integer  "person_id"
    t.date     "date"
    t.text     "accusation"
    t.text     "outcome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accusations", ["person_id"], :name => "index_accusations_on_person_id"

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resource_type"
    t.integer  "resource_id"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",      :limit => 25
    t.string   "last_name",       :limit => 50
    t.string   "email",           :limit => 100, :default => "", :null => false
    t.string   "hashed_password", :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",        :limit => 25
    t.string   "salt",            :limit => 40
  end

  add_index "admin_users", ["username"], :name => "index_admin_users_on_username"

  create_table "admin_users_pages", :id => false, :force => true do |t|
    t.integer "admin_user_id"
    t.integer "page_id"
  end

  add_index "admin_users_pages", ["admin_user_id", "page_id"], :name => "index_admin_users_pages_on_admin_user_id_and_page_id"

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
    t.string   "chamber"
    t.text     "about"
    t.text     "jurisdiction"
  end

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "csv_earmark_id"
    t.integer  "import_reference_id"
    t.string   "fiscal_year"
    t.string   "budget_amount"
    t.string   "house_amount"
    t.string   "senate_amount"
    t.string   "omni_amount"
    t.string   "final_amount"
    t.text     "bill"
    t.text     "bill_section"
    t.text     "bill_subsection"
    t.text     "description"
    t.text     "notes"
    t.string   "presidential"
    t.string   "undisclosed"
    t.text     "house_members"
    t.text     "house_parties"
    t.text     "house_states"
    t.text     "house_districts"
    t.text     "senate_members"
    t.text     "senate_parties"
    t.text     "senate_states"
    t.text     "recipient"
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

  create_table "issue_main_issues", :force => true do |t|
    t.integer  "issue_id"
    t.integer  "main_issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.text     "summary"
    t.integer  "introduced_year"
  end

  add_index "legislations", ["bill_uri"], :name => "index_legislations_on_bill_uri"

  create_table "legislative_offices", :force => true do |t|
    t.integer  "person_id"
    t.string   "congress_year"
    t.string   "chamber"
    t.string   "state"
    t.string   "district"
    t.string   "party"
    t.string   "seniority"
    t.string   "start_date"
    t.string   "end_date"
    t.integer  "bills_sponsored"
    t.integer  "bills_cosponsored"
    t.string   "missed_votes_pct"
    t.string   "votes_with_party_pct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "legislative_offices", ["person_id"], :name => "index_legislative_offices_on_person_id"

  create_table "litigations", :force => true do |t|
    t.integer  "person_id"
    t.date     "date"
    t.text     "litigation"
    t.text     "outcome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "litigations", ["person_id"], :name => "index_litigations_on_person_id"

  create_table "main_issues", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "pages", :force => true do |t|
    t.integer  "subject_id"
    t.string   "name"
    t.string   "permalink"
    t.integer  "position"
    t.boolean  "visible",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"
  add_index "pages", ["subject_id"], :name => "index_pages_on_subject_id"

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
    t.string   "net_worth_minimum"
    t.string   "net_worth_average"
    t.string   "net_worth_maximum"
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
    t.string   "fec_id"
    t.string   "crp_id"
    t.string   "votesmart_id"
    t.text     "slug"
  end

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

  create_table "section_edits", :force => true do |t|
    t.integer  "admin_user_id"
    t.integer  "section_id"
    t.string   "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "section_edits", ["admin_user_id", "section_id"], :name => "index_section_edits_on_admin_user_id_and_section_id"

  create_table "sections", :force => true do |t|
    t.integer  "page_id"
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",      :default => false
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["page_id"], :name => "index_sections_on_page_id"

  create_table "subcommittee_assignments", :force => true do |t|
    t.integer  "person_id"
    t.integer  "subcommittee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcommittee_assignments", ["person_id"], :name => "index_subcommittee_assignments_on_person_id"
  add_index "subcommittee_assignments", ["subcommittee_id"], :name => "index_subcommittee_assignments_on_subcommittee_id"

  create_table "subcommittees", :force => true do |t|
    t.integer  "committee_id"
    t.string   "name"
    t.string   "code"
    t.string   "chamber"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcommittees", ["committee_id"], :name => "index_subcommittees_on_committee_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

end

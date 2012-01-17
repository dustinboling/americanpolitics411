# == Schema Information
#
# Table name: people
#
#  id                      :integer         not null, primary key
#  first_name              :string(255)
#  middle_name             :string(255)
#  last_name               :string(255)
#  suffix                  :string(255)
#  date_of_birth           :date
#  date_of_death           :date
#  bio                     :text
#  position                :integer
#  created_at              :datetime
#  updated_at              :datetime
#  professional_experience :text
#  literary_work           :text
#  religion_id             :integer
#  current_residence       :string(255)
#  dates_in_office         :text
#  photo_url               :string(255)
#  contact_street_address  :string(255)
#  contact_city            :string(255)
#  contact_state           :string(255)
#  contact_zip             :integer
#  contact_phone           :string(255)
#  contact_fax             :string(255)
#  contact_email           :string(255)
#  contact_web_page_name   :string(255)
#  contact_web_page_url    :string(255)
#  net_worth_ranking       :integer
#  net_worth_minimum       :integer
#  net_worth_average       :integer
#  net_worth_maximum       :integer
#  family_members_id       :integer
#

class Person < ActiveRecord::Base
  
  belongs_to :religion
  
  # maps to edit -> relationships tab
  has_many :family_members
  accepts_nested_attributes_for :family_members, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  
  has_many :business_associates
  accepts_nested_attributes_for :business_associates, :reject_if => lambda { |b| b[:full_name].blank? }, :allow_destroy => true
  
  # maps to edit -> financial tab
  has_many :personal_assets
  accepts_nested_attributes_for :personal_assets, :reject_if => lambda { |c| c[:action].blank? }, :allow_destroy => true
  
  has_many :transactions
  accepts_nested_attributes_for :transactions, :reject_if => lambda { |d| d[:action].blank? }, :allow_destroy => true
  
  # maps to edit -> education tab
  has_many :degrees
  accepts_nested_attributes_for :degrees, :reject_if => lambda { |e| e[:degree_earned].blank? }, :allow_destroy => true
  has_many :universities, :through => :degrees
  
  
  
  has_many :articles
  has_many :flip_flops
  has_and_belongs_to_many :organizations
  has_many :endorsements
  has_many :accusations
  has_many :litigations
  
  
  has_many :contributors
  has_many :campaign_platforms
  has_many :sponsored_legislations
  has_many :earmarks
  has_many :political_offices
  has_many :contributors_pacs
  has_many :contributors_interest_groups
  has_many :contributors_interest_group_sectors
  has_many :professional_experiences
  
  has_many :person_videos
  has_many :videos, :through => :person_videos
  
  validates_presence_of :first_name, :last_name, :date_of_birth, :religion
  
  scope :sorted, order('people.person_id ASC')
  
  
  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end
  
end

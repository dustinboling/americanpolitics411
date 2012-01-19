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
  
  # maps to edit -> political
  has_many :endorsements
  accepts_nested_attributes_for :endorsements, :reject_if => lambda { |f| f[:organization_id].blank? }, :allow_destroy => true
  
  has_many :issue_positions
  accepts_nested_attributes_for :issue_positions, :reject_if => lambda { |g| g[:issue_topic].blank? }, :allow_destroy => true

  has_many :flip_flops
  accepts_nested_attributes_for :flip_flops, :allow_destroy => true
  
  has_many :campaign_platforms
  accepts_nested_attributes_for :campaign_platforms, :reject_if => lambda { |h| h[:topic].blank? }, :allow_destroy => true
  
  # maps to edit -> controversy
  has_many :accusations
  accepts_nested_attributes_for :accusations, :allow_destroy => true
  
  has_many :litigations
  accepts_nested_attributes_for :litigations, :allow_destroy => true
  
  # maps to edit -> establishment
  has_many :political_offices
  accepts_nested_attributes_for :political_offices, :allow_destroy => true
  
  has_many :contributors
  accepts_nested_attributes_for :contributors, :allow_destroy => true
  
  has_many :earmarks
  accepts_nested_attributes_for :earmarks, :allow_destroy => true
  
  has_many :contributors_pacs
  accepts_nested_attributes_for :contributors_pacs, :allow_destroy => true
  
  has_many :contributors_interest_groups
  accepts_nested_attributes_for :contributors_interest_groups, :allow_destroy => true
  
  has_many :contributors_interest_group_sectors
  accepts_nested_attributes_for :contributors_interest_group_sectors, :allow_destroy => true
   
  # maps to edit -> attachments
  has_many :person_videos
  # has_many :videos, :through => :person_videos
  has_many :videos
  accepts_nested_attributes_for :videos, :allow_destroy => true
  
  has_many :articles
  accepts_nested_attributes_for :articles, :allow_destroy => true
  
  # ! not part of nested form (yet) !
  has_and_belongs_to_many :organizations
  has_many :sponsored_legislations
  has_many :professional_experiences
  

  
  validates_presence_of :first_name, :last_name, :date_of_birth, :religion
  
  scope :sorted, order('people.person_id ASC')
  
  # use slugs for urls
  def to_param
    "#{id} #{full_name}".parameterize
  end
  
  def full_name
    if !suffix.blank?
      "#{first_name} #{middle_name} #{last_name}, #{suffix}"
    else
      "#{first_name} #{middle_name} #{last_name}"
    end
  end
  
end

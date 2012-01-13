class Person < ActiveRecord::Base
  
  belongs_to :religion
  has_many :universities, :through => :degrees
  has_many :degrees
  has_many :family_members
  has_many :videos
  has_many :articles
  has_many :flip_flops
  has_and_belongs_to_many :organizations
  has_many :business_associates
  has_many :endorsements
  has_many :accusations
  has_many :litigations
  has_many :transactions
  has_many :personal_assets
  has_many :contributors
  has_many :campaign_platforms
  has_many :sponsored_legislations
  has_many :earmarks
  has_many :political_offices
  has_many :contributors_pacs
  has_many :contributors_interest_groups
  has_many :contributors_interest_group_sectors
  
  validates_presence_of :first_name, :last_name, :date_of_birth, :religion
  
  scope :sorted, order('people.person_id ASC')
  
  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end
  
end
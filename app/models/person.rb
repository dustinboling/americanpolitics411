class Person < ActiveRecord::Base
  
  attr_accessible :first_name, :middle_name, :last_name, :title, :suffix, :religion_id, :date_of_birth, :date_of_death, :bio, :professional_experience, :literary_work, :contact_street_address,  :contact_city, :contact_state, :contact_zip, :twitter_id, :youtube_id, :contact_phone, :contact_fax, :contact_email, :contact_web_page_name, :contact_web_page_url, :photo_url, :birthplace, :is_congress_member, :net_worth_minimum, :net_worth_average, :net_worth_maximum, :business_associates_attributes, :family_members_attributes, :personal_assets_attributes, :transactions_attributes, :degrees_attributes, :endorsements_attributes, :issue_positions_attributes, :flip_flops_attributes, :campaign_platforms_attributes, :accusations_attributes, :litigations_attributes, :political_offices_attributes, :supporters_attributes, :addresses_attributes, :organization_people_attributes

  validates_presence_of :first_name, :last_name, :religion_id

  before_create :set_name
  before_update :set_name
  before_save :set_slug
  
  belongs_to :religion
  
  has_many :person_votes
  has_many :legislative_offices
  
  has_many :legislation_cosponsors
  has_many :legislations, :through => :legislation_cosponsors
  
  has_many :subcommittee_assignments
  has_many :subcommittees, :through => :subcommittee_assignments
  
  has_many :committee_assignments
  has_many :committees, :through => :committee_assignments

  has_many :organization_people
  accepts_nested_attributes_for :organization_people, :allow_destroy => true
  
  # maps to edit -> contact tab
  has_many :addresses
  accepts_nested_attributes_for :addresses, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true

  # maps to edit -> relationships tab
  has_many :family_members
  accepts_nested_attributes_for :family_members, :reject_if => lambda { |a| a[:person_id].blank? }, :allow_destroy => true
  
  has_many :business_associates
  accepts_nested_attributes_for :business_associates, :reject_if => lambda { |b| b[:full_name].blank? }, :allow_destroy => true
  
  # maps to edit -> financial tab
  has_many :personal_assets
  accepts_nested_attributes_for :personal_assets, :reject_if => lambda { |c| c[:organization_id].blank? }, :allow_destroy => true
  
  has_many :transactions
  accepts_nested_attributes_for :transactions, :reject_if => lambda { |d| d[:organization_id].blank? }, :allow_destroy => true
  
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
  
  has_many :earmarks
  accepts_nested_attributes_for :earmarks, :allow_destroy => true
  
  has_many :supporters
  accepts_nested_attributes_for :supporters, :allow_destroy => true
  
  has_many :contributors
  accepts_nested_attributes_for :contributors, :allow_destroy => true

  # stuff from here down can probably be deleted 
  # ALSO delete from DB
  # maps to edit -> attachments
  has_many :person_videos
  # has_many :videos, :through => :person_videos
  has_many :videos
  accepts_nested_attributes_for :videos, :allow_destroy => true
  
  has_many :articles
  accepts_nested_attributes_for :articles, :allow_destroy => true
  
  scope :sorted, order('people.person_id ASC')
  
  def set_name
    self.name = self.first_name + " " + self.last_name
  end
  
  def set_slug
    self.slug = "#{self.id}" + "-" + self.first_name + "-" + self.last_name
    self.slug = self.slug.gsub(/ /, "-")
  end
  
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
  
  def first_last_name
    "#{first_name} #{last_name}"
  end
  
  def remove_name_numericality
    self.first_last_name.gsub(/\b III/, '').gsub(/\b II/, '')
  end
  
  def find_university_name
    self.University.find(x.university_id).name
  end
  
  def find_person_name
    self.Person.find(y.person_id).name
  end
  
  def supporter_numbers
    self.supporters.collect { |supporter| "#{supporter.support_percentage}".to_i }
  end
  
  def supporter_legend
    self.supporters.each_with_index { |supporter, i| supporter.group_name }
  end
  
end

class Person < ActiveRecord::Base
  
  validates_presence_of :first_name, :last_name
  
  before_create :set_name
  before_update :set_name
  
  def set_name
    self.name = self.first_name + " " + self.last_name
  end
  
  belongs_to :religion
  
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
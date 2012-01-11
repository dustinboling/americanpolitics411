class Person < ActiveRecord::Base
  
  has_many :universities, :through => :degrees
  has_many :degrees
  belongs_to :religion
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
  
  validates_presence_of :first_name, :last_name, :date_of_birth, :religion
  
  scope :sorted, order('people.person_id ASC')
  
end
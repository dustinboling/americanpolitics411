class Legislation < ActiveRecord::Base

  attr_accessible :rtc_id, :bill_type, :bill_number, :session, :introduced_year, :introduced_date, :chamber, :short_title, :bill_title, :popular_title, :summary, :bill_sponsor, :bill_sponsor_id, :bill_pdf, :latest_major_action, :latest_major_action_date

  before_save :set_introduced_year

  has_many :actions
  has_many :passage_votes
  has_many :person_votes

  has_many :committee_legislations
  has_many :committees, :through => :committee_legislations

  has_many :legislation_cosponsors
  has_many :people, :through  => :legislation_cosponsors

  has_many :legislation_issues
  has_many :issues, :through => :legislation_issues

  SESSIONS = [112, 111]
  YEARS = [2012, 2011, 2010, 2009, 2008]

  def set_introduced_year
    unless self.introduced_year.nil?
      self.introduced_year = self.introduced_date.split('-').shift
    end
  end

end

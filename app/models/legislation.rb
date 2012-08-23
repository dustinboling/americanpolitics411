class Legislation < ActiveRecord::Base

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

  def set_introduced_year
    unless self.introduced_year.nil?
      self.introduced_year = self.introduced_date.split('-').shift
    end
  end

end

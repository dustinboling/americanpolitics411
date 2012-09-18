class CommitteeLegislation < ActiveRecord::Base

  attr_accessible :committee_id, :legislation_id

  belongs_to :committee
  belongs_to :legislation

  def self.does_not_exist(committee_id, legislation_id)
    if self.find_by_committee_id_and_legislation_id(committee_id, legislation_id)
      false
    else
      true
    end
  end

  def self.exists?(committee_id, legislation_id)
    if self.find_by_committee_id_and_legislation_id(committee_id, legislation_id)
      true
    else
      false
    end
  end

end

class CommitteeLegislation < ActiveRecord::Base

  attr_accessible :committee_id, :legislation_id

  belongs_to :committee
  belongs_to :legislation

end

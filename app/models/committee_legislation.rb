class CommitteeLegislation < ActiveRecord::Base
  belongs_to :committee
  belongs_to :legislation
  
end

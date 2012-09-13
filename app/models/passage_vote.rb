class PassageVote < ActiveRecord::Base

  attr_accessible :legislation_id, :result, :voted_at, :passage_vote, :text, :how, :roll_id, :chamber

  belongs_to :legislation
end

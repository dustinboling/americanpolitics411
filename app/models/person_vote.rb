class PersonVote < ActiveRecord::Base
  belongs_to :person
  belongs_to :legislation
end

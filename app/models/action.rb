class Action < ActiveRecord::Base

  attr_accessible :legislation_id, :acted_at, :text

  belongs_to :legislation
end

class PersonVideo < ActiveRecord::Base
  belongs_to :person
  belongs_to :video
end

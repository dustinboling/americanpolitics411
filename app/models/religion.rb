# == Schema Information
#
# Table name: religions
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Religion < ActiveRecord::Base
  has_and_belongs_to_many :people
  
end

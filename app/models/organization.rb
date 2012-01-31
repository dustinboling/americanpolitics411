# == Schema Information
#
# Table name: organizations
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Organization < ActiveRecord::Base
  
  validates_uniqueness_of :name
  
  has_many :people
  
  
end

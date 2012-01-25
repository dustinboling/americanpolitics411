# == Schema Information
#
# Table name: universities
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  person_id  :integer
#  degree_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class University < ActiveRecord::Base
  
  validates_presence_of :name
  
  has_many :people, :through => :degrees
  has_many :degrees
  
  scope :sorted, order('universities.id ASC')
  
end

# == Schema Information
#
# Table name: degrees
#
#  id            :integer         not null, primary key
#  university_id :integer
#  person_id     :integer
#  degree_earned :string(255)
#  year_earned   :date
#  created_at    :datetime
#  updated_at    :datetime
#

class Degree < ActiveRecord::Base
  belongs_to :university
  belongs_to :person
  
  def university_name
    university.try(:name)
  end
  
  def university_name=(name)
    self.university = University.find_or_create_by_name(name) if name.present?
  end

end

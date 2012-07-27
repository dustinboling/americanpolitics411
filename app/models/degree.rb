class Degree < ActiveRecord::Base

  attr_accessible :person_id, :university_name, :year_earned, :degree_earned
  belongs_to :university
  belongs_to :person
  
  def university_name
    university.try(:name)
  end
  
  def university_name=(name)
    self.university = University.find_or_create_by_name(name) if name.present?
  end
  
  def find_university_name
    University.find(university_id).name
  end

end

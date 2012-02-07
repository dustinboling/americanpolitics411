class Degree < ActiveRecord::Base
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
  
  def no_separator
    options={:words_connector => '', :two_words_connector => '', :last_word_connector => ''}
  end

end

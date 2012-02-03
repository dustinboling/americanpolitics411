# == Schema Information
#
# Table name: family_members
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  relationship :string(255)
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#  person_id    :integer
#

class FamilyMember < ActiveRecord::Base
  belongs_to :person
  belongs_to :family_member
  
  def find_person_name
    Person.find(family_member).full_name
  end
  
  def person_name
    family_member.try(:name)
  end
  
  def person_name=(name)
    self.family_member = Family_member.find_or_create_by_person_id_and_family_member_id(name) if name.present?
  end
  
end

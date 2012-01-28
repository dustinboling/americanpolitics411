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
  
  def find_person_name
    Person.find(family_member).full_name
  end
  
end

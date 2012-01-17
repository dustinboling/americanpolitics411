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
  
end

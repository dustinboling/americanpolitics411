# == Schema Information
#
# Table name: earmarks
#
#  id              :integer         not null, primary key
#  person_id       :integer
#  organization_id :integer
#  description     :text
#  sector          :string(255)
#  amount          :integer
#  year            :date
#  created_at      :datetime
#  updated_at      :datetime
#

class Earmark < ActiveRecord::Base
  belongs_to :person
  belongs_to :organization
  
end

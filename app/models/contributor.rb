# == Schema Information
#
# Table name: contributors
#
#  id              :integer         not null, primary key
#  person_id       :integer
#  organization_id :integer
#  amount          :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Contributor < ActiveRecord::Base
  belongs_to :person
  belongs_to :organization
  
end

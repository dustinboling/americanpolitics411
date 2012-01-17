# == Schema Information
#
# Table name: sponsored_legislations
#
#  id               :integer         not null, primary key
#  person_id        :integer
#  sponsor          :boolean
#  bill_number      :string(255)
#  year_of_congress :date
#  url              :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class SponsoredLegislation < ActiveRecord::Base
  belongs_to :person
end

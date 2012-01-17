# == Schema Information
#
# Table name: political_offices
#
#  id            :integer         not null, primary key
#  person_id     :integer
#  position      :string(255)
#  district      :string(255)
#  office        :string(255)
#  date_started  :date
#  date_finished :date
#  created_at    :datetime
#  updated_at    :datetime
#

class PoliticalOffice < ActiveRecord::Base
  belongs_to :person
  
end

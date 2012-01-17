# == Schema Information
#
# Table name: litigations
#
#  id         :integer         not null, primary key
#  person_id  :integer
#  date       :date
#  litigation :text
#  outcome    :text
#  created_at :datetime
#  updated_at :datetime
#

class Litigation < ActiveRecord::Base
  belongs_to :person
  
end

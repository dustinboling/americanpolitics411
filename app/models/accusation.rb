# == Schema Information
#
# Table name: accusations
#
#  id         :integer         not null, primary key
#  person_id  :integer
#  date       :date
#  accusation :text
#  outcome    :text
#  created_at :datetime
#  updated_at :datetime
#

class Accusation < ActiveRecord::Base
  belongs_to :person
  
end

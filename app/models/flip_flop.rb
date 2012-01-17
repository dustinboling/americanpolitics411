# == Schema Information
#
# Table name: flip_flops
#
#  id         :integer         not null, primary key
#  person_id  :integer
#  year       :date
#  issue      :text
#  flipflop   :text
#  created_at :datetime
#  updated_at :datetime
#

class FlipFlop < ActiveRecord::Base
  belongs_to :person
  
end

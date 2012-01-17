# == Schema Information
#
# Table name: supporters
#
#  id                 :integer         not null, primary key
#  group_name         :string(255)
#  support_percentage :string(255)
#  person_id          :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Supporter < ActiveRecord::Base
end

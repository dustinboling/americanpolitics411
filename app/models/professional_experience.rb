# == Schema Information
#
# Table name: professional_experiences
#
#  id              :integer         not null, primary key
#  person_id       :integer
#  organization_id :integer
#  position        :string(255)
#  date_started    :date
#  date_ended      :date
#  accomplishments :text
#  created_at      :datetime
#  updated_at      :datetime
#

class ProfessionalExperience < ActiveRecord::Base
  belongs_to :person
  belongs_to :organization
end

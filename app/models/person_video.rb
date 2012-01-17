# == Schema Information
#
# Table name: person_videos
#
#  id         :integer         not null, primary key
#  person_id  :integer
#  video_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class PersonVideo < ActiveRecord::Base
  belongs_to :person
  belongs_to :video
end

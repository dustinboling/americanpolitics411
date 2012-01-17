# == Schema Information
#
# Table name: videos
#
#  id            :integer         not null, primary key
#  person_id     :integer
#  date          :date
#  title         :string(255)
#  description   :text
#  video_url     :string(255)
#  thumbnail_url :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Video < ActiveRecord::Base
  has_many :person_videos
  has_many :people, :through => :person_videos
  
end

class Video < ActiveRecord::Base
  has_many :person_videos
  has_many :people, :through => :person_videos
  
end

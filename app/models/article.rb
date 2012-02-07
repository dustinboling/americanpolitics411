class Article < ActiveRecord::Base
  belongs_to :person
  has_many :attachments
  
end

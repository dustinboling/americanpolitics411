# == Schema Information
#
# Table name: articles
#
#  id          :integer         not null, primary key
#  person_id   :integer
#  title       :string(255)
#  excerpt     :text
#  article_url :string(255)
#  date        :date
#  created_at  :datetime
#  updated_at  :datetime
#

class Article < ActiveRecord::Base
  belongs_to :person
  has_many :attachments
  
end

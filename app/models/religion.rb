class Religion < ActiveRecord::Base
  
  attr_accessible :name

  validates_presence_of :name
  
  has_many :people
  
  def to_param
    "#{id} #{name}".parameterize
  end
  
end

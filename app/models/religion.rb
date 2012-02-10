class Religion < ActiveRecord::Base
  has_many :people
  
  def to_param
    "#{id} #{name}".parameterize
  end
  
end

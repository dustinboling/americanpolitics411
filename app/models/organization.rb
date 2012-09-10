class Organization < ActiveRecord::Base

  attr_accessible :name, :id

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :people

end

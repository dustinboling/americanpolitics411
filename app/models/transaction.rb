class Transaction < ActiveRecord::Base
  belongs_to :person
  belongs_to :organizatiion
  
end

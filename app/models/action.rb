class Action < ActiveRecord::Base

  attr_accessible :legislation_id, :acted_at, :text

  belongs_to :legislation

  def self.does_not_exist(legislation_id, acted_at, text)
    if self.find_by_legislation_id_and_acted_at_and_text(legislation_id, acted_at, text)
      false
    else
      true
    end
  end

end

class Update < ActiveRecord::Base

  attr_accessible :task, :utc_timestamp, :count

  before_save :set_utc_timestamp

  def set_utc_timestamp
    self.utc_timestamp = Time.now.utc
  end
end

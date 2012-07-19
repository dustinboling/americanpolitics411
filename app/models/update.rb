class Update < ActiveRecord::Base
  before_save :set_utc_timestamp

  def set_utc_timestamp
    self.utc_timestamp = Time.now.utc
  end
end

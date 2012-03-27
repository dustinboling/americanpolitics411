require 'spec_helper'

describe Religion do
  it "should require a name" do
    @r = Religion.create(:name => "")
    @r.should_not be_valid
  end
end
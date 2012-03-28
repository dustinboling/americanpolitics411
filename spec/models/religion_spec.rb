require 'spec_helper'

describe Religion do
  it "should require a name" do
    @r = Religion.create(:name => "")
    @r.should_not be_valid
  end
  
  it "should have many people" do
    r = Religion.reflect_on_association(:people)
    r.macro.should eq(:has_many)
  end
  
end
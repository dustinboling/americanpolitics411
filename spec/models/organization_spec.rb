require 'spec_helper'

describe Organization do
  it "should require a name" do
    @o = Organization.create(:name => "")
    @o.should_not be_valid
  end
  
  it "should require a name to be unique" do
    @o1 = Organization.create(:name => "not_unique")
    @o2 = Organization.create(:name => "not_unique")
    
    @o2.should_not be_valid
  end
  
  it "should have many people" do
    o = Organization.reflect_on_association(:people)
    o.macro.should eq(:has_many)
  end
    
end
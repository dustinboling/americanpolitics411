require 'spec_helper'

describe Organization do
  it "should require a name" do
    o = Organization.create(:name => "")
    o.should_not be_valid
  end
  
  it "should require a unique name" do
    o1 = Organization.create(:name => "not_unique_name")
    o2 = Organization.create(:name => "not_unique_name")
    o2.should_not be_valid
  end
  
  it "should have many people" do
    o = Organization.reflect_on_association(:people)
    o.macro.should eq(:has_many)
  end
end
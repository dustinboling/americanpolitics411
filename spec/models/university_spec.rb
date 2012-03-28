require 'spec_helper'

describe University do
  it "should require a name" do
    @university = University.create(:name => "")
    @university.should_not be_valid
  end
  
  it "should have many people" do
    u = University.reflect_on_association(:people)
    u.macro.should eq(:has_many)
  end
  
end
require 'spec_helper'

describe University do
  it "should require a name" do
    @university = University.create(:name => "")
    @university.should_not be_valid
  end
end
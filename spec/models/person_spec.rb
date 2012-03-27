require 'spec_helper'

describe Person do
  
  it "should have a valid factory" do
    Factory(:person).should be_valid
  end
  
  # methods
  describe "remove_name_numericality" do
    it "should remove the numbers people have to indicate what generation they are" do
      @p1 = Factory(:person, :first_name => "Emanuel", :last_name => "Cleaver II")
      @p2 = Factory(:person, :first_name => "Emanuel", :last_name => "Cleaver III")
      
      @p1.remove_name_numericality.should eq("Emanuel Cleaver")
      @p2.remove_name_numericality.should eq("Emanuel Cleaver")
    end
  end
  
end
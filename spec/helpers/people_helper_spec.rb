require 'spec_helper'

describe PeopleHelper do
  describe "party_breakdown" do
  end
  
  describe "state_federal_breakdown" do
  end
  
  describe "contributions_by_sector_math" do
    it "should count the total amount" do
      m1 = Hashie::Mash.new 
      m1.amount = 1
      m2 = Hashie::Mash.new
      m2.amount = 10
      m3 = Hashie::Mash.new
      m3.amount = 20
      
      @sectors = [m1, m2, m3]
      contributions_by_sector_math
      
      @i.should eq(31)
    end
  end
  
  describe "get_tweet_ids" do
  end
end

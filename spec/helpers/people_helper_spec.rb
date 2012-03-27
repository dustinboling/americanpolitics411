require 'spec_helper'

describe PeopleHelper do
  describe "party_breakdown" do
    it "gives a party breakdown for contributors to a congressperson" do
      @ids = []
      @names = ["Max Baucus", "Scott Brown", "Harry Reid", "Ron Wyden", "Emanuel Cleaver II"]
      @names.each do |name|
        @entity = TransparencyData::Client.entities(:search => name)
        @id = @entity.first.id
        @ids << @id
      end
      
      @ids.each do |id|
        @stats = TransparencyData::Client.individual_party_breakdown(id)
        @stats.should_not be_nil
      end
    end
  end
  
end
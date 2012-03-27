require 'spec_helper'

describe Person do
  
  it "should have a valid factory" do
    Factory(:person).should be_valid
  end
  
  # validations
  it "should require a first name" do
    Factory.build(:person, :first_name => "").should_not be_valid
  end
  
  it "should require a last name" do
    Factory.build(:person, :last_name => "").should_not be_valid
  end
  
  # associations
  it "should belong to a religion" do
    p = Person.reflect_on_association(:religion)
    p.macro.should eq(:belongs_to)
  end

  it "should have many lelgislative offices" do
    p = Person.reflect_on_association(:legislative_offices)
    p.macro.should eq(:has_many)
  end
  
  it "should have many legislation cosponsors" do
    p = Person.reflect_on_association(:legislation_cosponsors)
    p.macro.should eq(:has_many)
  end
  
  it "should have many subcommittee assignments" do
    p = Person.reflect_on_association(:subcommittee_assignments)
    p.macro.should eq(:has_many)
  end
  
  it "should have many committee assignments" do
    p = Person.reflect_on_association(:committee_assignments)
    p.macro.should eq(:has_many)
  end
  
  it "should have many family memebers" do
    p = Person.reflect_on_association(:family_members)
    p.macro.should eq(:has_many)
  end
  
  it "should have many business associates" do
    p = Person.reflect_on_association(:business_associates)
    p.macro.should eq(:has_many)
  end
  
  it "should have many personal asssets" do
    p = Person.reflect_on_association(:personal_assets)
    p.macro.should eq(:has_many)
  end
  
  it "should have many transactions" do
    p = Person.reflect_on_association(:transactions)
    p.macro.should eq(:has_many)
  end
  
  it "should have many degrees" do
    p = Person.reflect_on_association(:degrees)
    p.macro.should eq(:has_many)
  end
  
  it "should have many endorsements" do
    p = Person.reflect_on_association(:endorsements)
    p.macro.should eq(:has_many) 
  end
  
  it "should have many issue positions" do
    p = Person.reflect_on_association(:issue_positions)
    p.macro.should eq(:has_many)
  end
  
  it "should have many flip flops" do
    p = Person.reflect_on_association(:flip_flops)
    p.macro.should eq(:has_many)
  end
  
  it "should have many campaign platforms" do
    p = Person.reflect_on_association(:campaign_platforms)
    p.macro.should eq(:has_many)
  end
  
  it "should have many accusations" do
    p = Person.reflect_on_association(:accusations)
    p.macro.should eq(:has_many)
  end
  
  it "should have many litigations" do
    p = Person.reflect_on_association(:litigations)
    p.macro.should eq(:has_many)
  end
  
  it "should have many political offices" do
    p = Person.reflect_on_association(:political_offices)
    p.macro.should eq(:has_many)
  end
  
  it "should have many earmarks" do
    p = Person.reflect_on_association(:earmarks)
    p.macro.should eq(:has_many)
  end
  
  it "should have many supporters" do
    p = Person.reflect_on_association(:supporters)
    p.macro.should eq(:has_many)
  end
  
  it "should have many contributors" do
    p = Person.reflect_on_association(:contributors)
    p.macro.should eq(:has_many)
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
  
  describe "set_name" do
    it "should set a persons name field on save" do
      @p = Factory(:person)
      @p.save
      
      @p.name.should eq("#{@p.first_name} #{@p.last_name}")
    end
  end
  
  describe "set_slug" do
    it "should set a person's slug on save" do
      @p = Factory(:person)
      @p.save
      
      @p.slug.should eq("#{@p.id}-#{@p.first_name}-#{@p.last_name}")
    end
  end
  
end
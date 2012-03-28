require 'spec_helper'

describe Ability do
  it "does nothing (but actually does, need to test later, then again maybe the request specs are enough)" do
  end
end

describe Accusation do
  it "should belong to person" do
    a = Accusation.reflect_on_association(:person)
    a.macro.should eq(:belongs_to)
  end
end

describe BusinessAssociate do
  it "should belong to person" do
    ba = BusinessAssociate.reflect_on_association(:person)
    ba.macro.should eq(:belongs_to)
  end
  
  it "should belong to organization" do
    ba = BusinessAssociate.reflect_on_association(:organization)
    ba.macro.should eq(:belongs_to)
  end
end

describe CampaignPlatform do
  it "should belong to person" do
    cp = CampaignPlatform.reflect_on_association(:person)
    cp.macro.should eq(:belongs_to)
  end
end

describe Committee do
  it "should have many subcommittees" do
    c = Committee.reflect_on_association(:subcommittees)
    c.macro.should eq(:has_many)
  end
  
  it "should have many committee_assignments" do
    c = Committee.reflect_on_association(:committee_assignments)
    c.macro.should eq(:has_many)
  end
  
  it "should have many people through committee assignments" do
    c = Committee.reflect_on_association(:people)
    c.macro.should eq(:has_many)
  end
  
  it "should have many committee_legislations" do
    c = Committee.reflect_on_association(:committee_legislations)
    c.macro.should eq(:has_many)
  end
  
  it "should have many legislations" do
    c = Committee.reflect_on_association(:legislations)
    c.macro.should eq(:has_many)
  end
end

describe CommitteeAssignment do
  it "should belong to person" do
    c = CommitteeAssignment.reflect_on_association(:person)
    c.macro.should eq(:belongs_to)
  end
  
  it "should belong to committee" do
    c = CommitteeAssignment.reflect_on_association(:committee)
    c.macro.should eq(:belongs_to)
  end
end

describe CommitteeLegislation do
  it "should belong to legislation" do
    c = CommitteeLegislation.reflect_on_association(:legislation)
    c.macro.should eq(:belongs_to)
  end
  
  it "should belong to committee" do
    c = CommitteeLegislation.reflect_on_association(:committee)
    c.macro.should eq(:belongs_to)
  end
end

describe Degree do
  it "should belong to university" do
    d = Degree.reflect_on_association(:university)
    d.macro.should eq(:belongs_to)
  end
  
  it "should belong to person" do
    d = Degree.reflect_on_association(:person)
    d.macro.should eq(:belongs_to)
  end
end

describe Earmark do
  it "should belong to organization" do
    e = Earmark.reflect_on_association(:organization)
    e.macro.should eq(:belongs_to)
  end
  
  it "should belong to person" do
    e = Earmark.reflect_on_association(:person)
    e.macro.should eq(:belongs_to)
  end
end

describe Endorsement do
  it "should belong to person" do
    e = Endorsement.reflect_on_association(:person)
    e.macro.should eq(:belongs_to)
  end
  
  it "should belong to organizations" do
    e = Endorsement.reflect_on_association(:organization)
    e.macro.should eq(:belongs_to)
  end
end

describe FamilyMember do
  it "should belong to person" do
    f = FamilyMember.reflect_on_association(:person)
    f.macro.should eq(:belongs_to)
  end
end

describe FlipFlop do
  it "should belong to person" do
    f = FlipFlop.reflect_on_association(:person)
    f.macro.should eq(:belongs_to)
  end
end

describe Issue do
  it "doesn't do anything" do
  end
end

describe IssuePosition do
  it "should belong to person" do
    i = IssuePosition.reflect_on_association(:person)
    i.macro.should eq(:belongs_to)
  end
end

describe Legislation do
  it "should have many committee_legislations" do
    l = Legislation.reflect_on_association(:committee_legislations)
    l.macro.should eq(:has_many)
  end
  
  it "should have many committees" do
    l = Legislation.reflect_on_association(:committees)
    l.macro.should eq(:has_many)
  end
  
  it "should have many legislation_cosponsors" do
    l = Legislation.reflect_on_association(:legislation_cosponsors)
    l.macro.should eq(:has_many)
  end
  
  it "should have many people" do
    l = Legislation.reflect_on_association(:people)
    l.macro.should eq(:has_many)
  end
  
  it "should have many legislation_issues" do
    l = Legislation.reflect_on_association(:legislation_issues)
    l.macro.should eq(:has_many)
  end
  
  it "should have many issues" do
    l = Legislation.reflect_on_association(:issues)
    l.macro.should eq(:has_many)
  end
end

describe LegislationCosponsor do
  it "should belong to person" do
    l = LegislationCosponsor.reflect_on_association(:person)
    l.macro.should eq(:belongs_to)
  end
  
  it "should belong to legislation" do
    l = LegislationCosponsor.reflect_on_association(:legislation)
    l.macro.should eq(:belongs_to)
  end
end

describe LegislativeOffice do
  it "should belong to person" do
    l = LegislativeOffice.reflect_on_association(:person)
    l.macro.should eq(:belongs_to)
  end
end

describe Litigation do
  it "should belong to person" do
    l = Litigation.reflect_on_association(:person)
    l.macro.should eq(:belongs_to)
  end
end

describe PersonalAsset do
  it "should belong to person" do
    p = PersonalAsset.reflect_on_association(:person)
    p.macro.should eq(:belongs_to)
  end
  
  it "shoud belong to organization" do
    p = PersonalAsset.reflect_on_association(:organization)
    p.macro.should eq(:belongs_to)
  end
end

describe PoliticalOffice do
  it "should belong to person" do
    p = PoliticalOffice.reflect_on_association(:person)
    p.macro.should eq(:belongs_to)
  end
end

describe Subcommittee do
  it "should belong to committee" do
    s = Subcommittee.reflect_on_association(:committee)
    s.macro.should eq(:belongs_to)
  end
  
  it "should have many subcommittee_assignment" do
    s = Subcommittee.reflect_on_association(:subcommittee_assignments)
    s.macro.should eq(:has_many)
  end
  
  it "should have many people" do
    s = Subcommittee.reflect_on_association(:people)
    s.macro.should eq(:has_many)
  end
end

describe SubcommitteeAssignment do
  it "should belong to subcommittee" do
    s = SubcommitteeAssignment.reflect_on_association(:subcommittee)
    s.macro.should eq(:belongs_to)
  end
  
  it "should belong to person" do
    s = SubcommitteeAssignment.reflect_on_association(:person)
    s.macro.should eq(:belongs_to)
  end
end

describe Supporter do
  it "does nothing" do
  end
end

describe Transaction do
  it "should belong to person" do
    t = Transaction.reflect_on_association(:person)
    t.macro.should eq(:belongs_to)
  end
  
  it "should belong to organization" do
    t = Transaction.reflect_on_association(:organization)
    t.macro.should eq(:belongs_to)
  end
end
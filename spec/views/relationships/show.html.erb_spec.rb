require 'spec_helper'

describe "relationships/show" do
  before(:each) do
    @relationship = assign(:relationship, stub_model(Relationship,
      :person_id => 1,
      :family_member_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end

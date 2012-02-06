require 'spec_helper'

describe "relationships/edit" do
  before(:each) do
    @relationship = assign(:relationship, stub_model(Relationship,
      :person_id => 1,
      :family_member_id => 1
    ))
  end

  it "renders the edit relationship form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => relationships_path(@relationship), :method => "post" do
      assert_select "input#relationship_person_id", :name => "relationship[person_id]"
      assert_select "input#relationship_family_member_id", :name => "relationship[family_member_id]"
    end
  end
end

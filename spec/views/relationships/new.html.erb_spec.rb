require 'spec_helper'

describe "relationships/new" do
  before(:each) do
    assign(:relationship, stub_model(Relationship,
      :person_id => 1,
      :family_member_id => 1
    ).as_new_record)
  end

  it "renders new relationship form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => relationships_path, :method => "post" do
      assert_select "input#relationship_person_id", :name => "relationship[person_id]"
      assert_select "input#relationship_family_member_id", :name => "relationship[family_member_id]"
    end
  end
end

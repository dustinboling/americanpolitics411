require 'spec_helper'

describe "People" do
  describe "GET /people" do
    it "displays people" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit people_path
      page.should have_content("All People")
    end
  end
end
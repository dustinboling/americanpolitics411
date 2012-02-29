require 'spec_helper'

describe "People" do
  describe "GET /senators" do
    it "displays a list of senators" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit senators_path
      response.body.should include("")
    end
  end
  
  describe "GET /representatives" do
    it "displays a list of representatives" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit representatives_path
      response.body.should include("")
    end
  end
  
  describe "GET /people" do
    it "displays a list of all people" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit people_path
      response.body.should include("")
    end
  end
  
end
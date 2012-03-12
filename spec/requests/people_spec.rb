require 'spec_helper'

describe "People" do
  describe "GET /senators" do
    it "displays a list of senators" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get senators_path
      response.body.should include("Senators")
    end
  end
  
  describe "GET /representatives" do
    it "displays a list of representatives" do
      get representatives_path
      response.body.should include("Representatives")
    end
  end
  
  describe "GET /people" do
    it "displays a list of all people" do
      get people_path
      response.body.should include("All People")
    end
  end
  
  describe "GET /committees" do
    it "displays a list of all committees" do
      get committees_index_path
      response.body.should include("Committees")
    end
  end
  
end
require 'spec_helper'

describe "People" do
  describe "GET /senators" do
    it "displays a list of senators" do
      visit senators_path
      page.should have_content("Senators")
    end
  end
  
  describe "GET /representatives" do
    it "displays a list of representatives" do
      visit representatives_path
      page.should have_content("Representatives")
    end
  end
  
  describe "GET /people" do
    it "displays a list of all people" do
      visit people_path
      page.should have_content("All People")
    end
  end
  
  describe "GET /committees" do
    it "displays a list of all committees" do
      visit committees_index_path
      page.should have_content("Committees")
    end
  end
end

describe "Legislation" do
  describe "GET /legislation" do
    it "displays a list of legislation" do
      visit legislation_index_path
      page.should have_content("Legislation")
    end
  end
  
end
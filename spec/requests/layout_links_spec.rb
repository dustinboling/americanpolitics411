require 'spec_helper'

describe "topbar" do
  describe "GET topbar links as anonymous" do
    it "should show home when anonymous clicks the logo" do
      visit root_url
      click_link("American Politics 411")
      page.should have_content("All People")
    end
    
    it "should show home page when anonymous clicks the home link" do
      visit root_url
      click_link("Home")
      page.should have_content("All People")
    end
    
    it "should show legislation when anonymous clicks the legislation link" do
      visit root_url
      click_link("Legislation")
      page.should have_content("Legislation for #{CURRENT_YEAR_CONGRESS} Year of Congress")
    end
    
    it "should show a list of senators when anonymous clicks the senators link" do
    
    end
    
    it "should show a list of representatives when anonymous clicks the representatives link" do
  
    end
    
  end
  
end
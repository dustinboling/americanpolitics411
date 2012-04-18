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
      visit root_url
      click_link("Senators")
      page.should have_content("Senators")
    end
    
    it "should show a list of representatives when anonymous clicks the senators link" do
      visit root_url
      click_link("Representatives")
      page.should have_content("Representatives")
    end
    
    it "should show a list of committees when anonymous clicks the committees link" do
      visit root_url
      click_link("Committees")
      page.should have_content("Committees")
    end
    
    it "should show a list of subcommittees when anonymous clicks the subcommittes link" do
      visit root_url
      click_link("Subcommittees")
      page.should have_content("Subcommittees")
    end
    
    it "should show the log in link" do
      visit root_url
      page.should have_link("log in")
    end
  end
  
  describe "GET topbar as admin" do
    before :each do 
      @user = FactoryGirl.create(:user, :roles_mask => 1)
      
      visit login_path
      fill_in "Username", :with => @user.username
      fill_in "Password", :with => '123'
      click_button "Log in"
    end
    
    it "should say 'Logged in!'" do
      page.should have_content("Logged in!")
    end
    
    it "should have a log out link" do
      page.should have_link("log out")
    end
    
    it "should not have a log in link" do
      page.should_not have_link("log in")
    end
    
    it "should not have a manage users link" do
      page.should_not have_link("Manage Users")
    end
    
    it "should not have a create a new user link" do
      page.should_not have_link("Create New User")
    end
    
    it "should show organizations#new when admin clicks add organization" do
      click_link "Add Organization"
      page.should have_content("New organization")
    end
    
    it "should show universities#new when admin clicks add university" do
      click_link "Add University"
      page.should have_content("New university")
    end
    
    it "should show universities#new when admin clicks add religion" do
      click_link "Add Religion"
      page.should have_content("New religion")
    end
    
    it "should show person#new when admin clicks create new person" do
      click_link "Create New Person"
      page.should have_content("New person")
    end    
  end
  
  describe "GET topbar as superadmin" do
    before :each do 
      @user = FactoryGirl.create(:user, :roles_mask => 2)
      
      visit login_path
      fill_in "Username", :with => @user.username
      fill_in "Password", :with => '123'
      click_button "Log in"
    end
    
    it "should say 'Logged in!'" do
      page.should have_content("Logged in!")
    end
    
    it "should say logged in as username" do
      page.should have_content("Logged in as #{@user.username}")
    end
    
    it "should have a log out link" do
      page.should have_link("log out")
    end
    
    it "should not have a log in link" do
      page.should_not have_link("log in")
    end
    
    it "should log out superadmin when they click " do
      click_link "log out"
      page.should have_content("Logged out")
    end
    
    it "should show organizations#new when superadmin clicks add organization" do
      click_link "Add Organization"
      page.should have_content("New organization")
    end
    
    it "should show universities#new when superadmin clicks add university" do
      click_link "Add University"
      page.should have_content("New university")
    end
    
    it "should show universities#new when superadmin clicks add religion" do
      click_link "Add Religion"
      page.should have_content("New religion")
    end
    
    it "should show person#new when superadmin clicks create new person" do
      click_link "Create New Person"
      page.should have_content("New person")
    end
    
    it "should show organizations#index when superadmin clicks organizations" do
      click_link "Organizations"
      page.should have_content("Listing organizations")
    end
    
    it "should show universities#index when superadmin clicks universities" do 
      click_link "Universities"
      page.should have_content("Listing universities")
    end
    
    it "should show religions#index when superadmin clicks religions" do
      click_link "Religions"
      page.should have_content("Listing religions")
    end
    
    it "should show a list of users when superadmin clicks manage legislation" do
      @legislation = Legislation.new
      @legislation.save
      
      click_link "Legislation"
      page.should have_link("Edit")
    end
    
    it "should show a list of users when superadmin clicks manage users" do
      click_link "Manage Users"
      page.should have_content("Manage Users")
    end
    
    it "should show users#new when superadmin clicks create new user" do
      click_link "Create New User"
      page.should have_content("Add new user")
    end  
  end
  
end

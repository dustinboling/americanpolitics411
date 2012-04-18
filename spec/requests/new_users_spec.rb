require 'spec_helper'

describe "NewUsers" do
  describe "POST users/new" do
    before :each do
      @superadmin = FactoryGirl.create(:user, :roles_mask => 2)
      @user = FactoryGirl.create(:user)
      
      visit login_path
      fill_in "Username", :with => @superadmin.username
      fill_in "Password", :with => '123'
      click_button "Log in"
      
      click_link "Create New User"
      fill_in "Password", :with => '123'
      fill_in "Password confirmation", :with => '123'
    end
    
    it "signs up a new superadmin when logged in as superadmin" do 
      fill_in "Username", :with => 'test_superadmin'
      check "superadmin"
      click_button "Create User"
      page.should have_content("Signed up!")
    end
    
    it "signs up a new admin when logged in as superadmin" do
      fill_in "Username", :with => "test_admin"
      check "admin"
      click_button "Create User"
      page.should have_content("Signed up!")
    end
    
    it "signs up a new reader when logged in as superadmin" do
      fill_in "Username", :with => "test_reader"
      check "reader"
      click_button "Create User"
      page.should have_content("Signed up!")
    end
  end
  
end

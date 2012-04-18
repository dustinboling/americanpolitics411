require 'spec_helper'

describe "NewUniversities" do
  describe "POST universities/new" do
    before :each do
      @user = FactoryGirl.create(:user, :roles_mask => 1)
    end
    
    it "should make a new university :as => admin" do
      visit login_path
      fill_in "Username", :with => @user.username
      fill_in "Password", :with => '123'
      click_button "Log in"
      
      visit new_university_path
      fill_in "Name", :with => "Test University (Test U)"
      click_button "Create University"
      page.should have_content("University was successfully created.")
      page.should have_content("Test University (Test U)")
    end
  end
end

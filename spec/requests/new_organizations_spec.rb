require 'spec_helper'

describe "NewOrganization" do
  describe "POST organizations/new" do
    it "should create a new organization" do
      @user = FactoryGirl.create(:user, :roles_mask => 1)
      
      visit login_path
      fill_in "Username", :with => @user.username
      fill_in "Password", :with => '123'
      click_button "Log in"
      
      visit new_organization_path
      fill_in "Name", :with => "TEST Organization"
      click_button "Create Organization"
      page.should have_content("Organization was successfully created")
      page.should have_content("TEST Organization")
    end
  end
end

require 'spec_helper'

describe "NewReligion" do
  describe "POST religion/new" do
    
    before :each do 
      @user = Factory(:user, :roles_mask => 1)
      
      visit login_path
      fill_in "Username", :with => @user.username
      fill_in "Password", :with => '123'
      click_button "Log in"
    end
    
    
    it "should make a new religion" do  
      visit new_religion_path
      fill_in "Name", :with => "TEST Religion"
      click_button "Create Religion"
      page.should have_content("Religion was successfully created.")
      page.should have_content("TEST Religion")
    end
  end

end
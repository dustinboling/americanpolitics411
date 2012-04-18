require 'spec_helper'

describe "Login" do
  
  before :each do
    @user = FactoryGirl.create(:user)
  end
  
  describe "User LOGIN" do
    it "logs the user in" do
      visit login_path
      fill_in "username", :with => @user.username
      fill_in "password", :with => '123'
      click_button "Log in"
      page.should have_content("Logged in!")
    end
  end
  
end

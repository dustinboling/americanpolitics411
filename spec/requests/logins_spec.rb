require 'spec_helper'

describe "Login" do
  
  before :each do
    @user = User.new(:email => "mail@example.com", :password => "secret", :username => "testuser")
  end
  
  describe "User LOGIN" do
    it "logs the user in" do
      # this is to use factory, delete before callback before doing so
      # user = Factory(:user)
      visit login_path
      fill_in "username", :with => @user.username
      fill_in "password", :with => @user.password
      click_button "Log in"
      page.should have_content("Logged in!")
    end
  end
  
end
require 'spec_helper'

describe "EditLegislation" do
  before :each do
    @user = Factory(:user, :roles_mask => 1)
    @legislation = Legislation.new(:bill_number => "TEST BILL NUMBER")
    @legislation.save
    
    visit login_path
    fill_in "Username", :with => @user.username
    fill_in "Password", :with => "123"
    click_button "Log in"
  end
  
  it "should show a single legislation" do
    visit legislation_index_path
    click_link "Edit"
    page.should have_content("TEST BILL NUMBER")
  end
  
end
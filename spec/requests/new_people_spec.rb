require 'spec_helper'

describe "NewPeople" do
  describe "POST people/new" do
    it "should create a new person" do
      @user = FactoryGirl.create(:user, :roles_mask => 1)
      @person = FactoryGirl.create(:person)
      
      visit login_path
      fill_in "Username", :with => @user.username
      fill_in "Password", :with => "123"
      click_button "Log in"
      
      click_link "Create New Person"
      fill_in "First name", :with => @person.first_name
      fill_in "Middle name", :with => @person.middle_name
      fill_in "Last name", :with => @person.last_name
      fill_in "Bio", :with => @person.bio
      fill_in "Professional experience", :with => @person.professional_experience
      fill_in "Literary work", :with => @person.literary_work
      click_button "Add Person"
      
      page.should have_content("#{@person.first_name}")
      page.should have_content("#{@person.last_name}")
      page.should have_content("#{@person.bio}")
      page.should have_content("#{@person.literary_work}")
      page.should have_content("#{@person.professional_experience}")
    end
  end
  
end

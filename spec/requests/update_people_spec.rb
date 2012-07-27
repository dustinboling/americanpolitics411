require 'spec_helper'

# NOTE: this needs some type of javascript integration with
# selenium or another library in order to work correctly
describe "UpdatePeople" do
  describe "POST people/update" do
    before :each do
      @user = FactoryGirl.create(:user, roles_mask: 1)
      @religion = FactoryGirl.create(:religion)
      @person = Person.new(
        first_name: 'test', 
        last_name: 'person', 
        religion_id: 7
      )
      @person.save

      visit login_path
      fill_in "Username", with: @user.username
      fill_in "Password", with: "123"
      click_button "Log in"
      visit person_path(@person)
      page.should have_content("#{@person.first_name}")
    end

    it "should allow the addition of contact info" do
    end

    it "should allow the addition of personal info" do
    end

    it "should allow the addition of relationships" do
    end

    it "should allow the addition of financial info" do
    end

    it "should allow the addition of education info" do
    end

    it "should allow the addition of political info" do
    end

    it "should allow the addition of controversy info" do
    end

    it "should allow the addition of establishment info" do
    end
  end
end

require 'spec_helper'

describe PeopleController do
  
  # these should all be publicly available
  describe "GET /all" do
    it "returns http success" do
      get :all
      response.should be_success
    end
  end
  
  describe "GET /index" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end
  
  describe "GET /senators" do
    it "returns http success" do
      get :senators
      response.should be_success
    end  
  end
  
  describe "GET /representatives" do
    it "returns http success" do
      get :representatives
      response.should be_success
    end
  end
  
  describe "GET /autocomplete_person_name" do
    it "returns http success" do
      get :autocomplete_person_name
      response.should be_success
    end
  end
  
  describe "GET /autocomplete_person_url" do
    it "returns http success" do
      get :autocomplete_person_url
      response.should be_success
    end
  end
  
  describe "GET /show" do
    it "returns http success" do
      p = Factory(:person)
      get :show, :id => p.id
      response.should be_success
    end
  end
  
  describe "GET /pac_contributors" do
    it "returns http success" do
      p = Factory(:person)
      get :pac_contributors, :id => p.id
      response.should be_success
    end
  end
  
  describe "GET /indiv_contributors" do
    it "returns http success" do
      p = Factory(:person)
      get :indiv_contributors, :id => p.id
      response.should be_success
    end
  end
  
  # these should not be publicly available
  describe "GET /destroy" do
    it "should redirect to root_url" do
      get :destroy
      response.should redirect_to(root_url)
    end
  end
  
  describe "GET /update" do
    it "should redirect to root_url" do
      get :update
      response.should redirect_to(root_url)
    end
  end
  
  describe "GET /create" do
    it "should redirect to root_url" do
      get :create
      response.should redirect_to(root_url)
    end
  end
  
  describe "GET /edit" do
    it "should redirect to root_url" do
      p  = Factory(:person)
      get :edit, :id => p.id
      response.should redirect_to(root_url)
    end
  end
  
  describe "GET /new" do
    it "should redirect to root_url" do
      p = Factory(:person)
      get :new, :id => p.id
      response.should redirect_to(root_url)
    end
  end
  
  # testing show controller for api functionality
  describe "GET /show, with person in TransparencyData database" do
    before :each do
      @p = Factory(:person, :first_name => "Ron", :last_name => "Paul", :name => "Ron Paul")
    end
    
    it "should return a list of pac contributors" do
      get :show, :id => @p.id
      
      @pac_contributors.should_not be_empty
      @individual_contributors.should_not be_empty
      @entity.should_not be_empty
    end
  end
  
  describe "GET /show, with person NOT in TransparencyData database" do
    
  end
  
end
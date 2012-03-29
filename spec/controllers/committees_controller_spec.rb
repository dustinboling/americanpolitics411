require 'spec_helper'

describe CommitteesController do
  
  # this should be publicly available
  describe "GET /committees" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end
  
  describe "GET /subcommittees" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end
  
end
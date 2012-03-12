require 'spec_helper'

describe "Committees" do
  describe "GET /committees" do
    it "successfully GETs /committees" do      
      get committees_index_path
      response.body.should include("Committees")
    end
  end
  
end
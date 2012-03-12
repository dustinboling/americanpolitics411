require 'spec_helper'

describe "Committees" do
  describe "GET /committees" do
    it "successfully GETs /committees" do      
      visit committees_index_path
      page.should have_content("Committees")
    end
  end
  
end
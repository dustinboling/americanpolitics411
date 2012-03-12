require 'spec_helper'

describe "Legislations" do
  describe "GET /legislation" do
    it "successfully GET legislation index" do
      visit legislation_index_path
      page.should have_content("Legislation for 112th Year of Congress")
    end
  end
  
end

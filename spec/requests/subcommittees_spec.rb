require 'spec_helper'

describe "Subcommittees" do
  describe "GET /subcommittees" do
    it "works! (now write some real specs)" do
      visit subcommittees_index_path
      page.should have_content("Subcommittees")
    end
  end
  
end
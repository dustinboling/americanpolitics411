require 'spec_helper'

describe "Subcommittees" do
  describe "GET /subcommittees" do
    it "works! (now write some real specs)" do
      get subcommittees_index_path
      response.body.should include("Subcommittees")
    end
  end
  
end
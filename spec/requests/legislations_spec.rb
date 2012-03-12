require 'spec_helper'

describe "Legislations" do
  describe "GET /legislation" do
    it "successfully GET legislation index" do
      get legislation_index_path
      response.body.should include("Legislation for 112th Year of Congress")
    end
  end
  
end

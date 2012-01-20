require 'spec_helper'

describe LegislationController do

  describe "GET 'grab_xml'" do
    it "returns http success" do
      get 'grab_xml'
      response.should be_success
    end
  end

end

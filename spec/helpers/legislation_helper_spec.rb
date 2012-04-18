require 'spec_helper'

describe LegislationHelper do
  describe "remove_hyphens" do
    it "should return properly formatted html" do
      summary = "----!--<p>Treats such regulations as regulations defining unfair and deceptive acts or practices affecting commerce prescribed under the Federal Trade Commission Act. </p>--"
      summary_should = "<p>Treats such regulations as regulations defining unfair and deceptive acts or practices affecting commerce prescribed under the Federal Trade Commission Act. </p>"
      remove_hyphens(summary).should eq(summary_should)
    end
  end
end

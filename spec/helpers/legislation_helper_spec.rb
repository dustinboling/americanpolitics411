require 'spec_helper'

describe LegislationHelper do
  describe "remove_hyphens" do
    it "should return properly formatted html" do
      summary = "----!--<p>Treats such regulations as regulations defining unfair and deceptive acts or practices affecting commerce prescribed under the Federal Trade Commission Act. </p>--"
      summary_should = "<p>Treats such regulations as regulations defining unfair and deceptive acts or practices affecting commerce prescribed under the Federal Trade Commission Act. </p>"
      remove_hyphens(summary).should eq(summary_should)
    end
  end

  describe "parse_summary" do
    it "should split a basic summary at periods" do
      summary = "This is a test summary with just a couple sentences.  Sometimes there is an extra space. Sometimes there is only one."
      summary_should = "This is a test summary with just a couple sentences.<br>Sometimes there is an extra space.<br>Sometimes there is only one."

      parse_summary(summary).should eq(summary_should)
    end

    it "should split up numbered lists" do
      summary = "Helping Innovation of Re-Employment Services in States Act or HIRES Act - Amends title III to authorize the Secretary of Labor to enter into agreements with states to allow them to conduct demonstration projects to test and evaluate measures designed to: (1) expedite the reemployment of individuals who establish initial eligibility for unemployment compensation under state law, or (2) improve the effectiveness of a state in carrying out its state law with respect to reemployment."
      summary_should = "Helping Innovation of Re-Employment Services in States Act or HIRES Act - Amends title III to authorize the Secretary of Labor to enter into agreements with states to allow them to conduct demonstration projects to test and evaluate measures designed to: <br>(1) expedite the reemployment of individuals who establish initial eligibility for unemployment compensation under state law, or <br>(2) improve the effectiveness of a state in carrying out its state law with respect to reemployment."

      parse_summary(summary).should eq(summary_should)
    end

    it "should not split up after parentheses that are not part of a numbered list" do
      summary = "Helping Innovation of Re-Employment Services in States Act or HIRES Act - Amends title III (Grants to States for Unemployment Compensation Administration) of the Social Security Act (SSA) to authorize the Secretary of Labor to enter into agreements with states to allow them to conduct demonstration projects to test and evaluate measures designed to: (1) expedite the reemployment of individuals who establish initial eligibility for unemployment compensation under state law, or (2) improve the effectiveness of a state in carrying out its state law with respect to reemployment."
      summary_should = "Helping Innovation of Re-Employment Services in States Act or HIRES Act - Amends title III (Grants to States for Unemployment Compensation Administration) of the Social Security Act (SSA) to authorize the Secretary of Labor to enter into agreements with states to allow them to conduct demonstration projects to test and evaluate measures designed to: <br>(1) expedite the reemployment of individuals who establish initial eligibility for unemployment compensation under state law, or <br>(2) improve the effectiveness of a state in carrying out its state law with respect to reemployment."

      parse_summary(summary).should eq(summary_should)
    end

    it "should not split up sentences within parentheses" do
      summary = "Helping Innovation of Re-Employment Services in States Act or HIRES Act - Amends title III (Grants to States for Unemployment Compensation Administration. Here is a second sentence to test against. And a third for good measure.) of the Social Security Act (SSA) to authorize the Secretary of Labor to enter into agreements with states to allow them to conduct demonstration projects to test and evaluate measures designed to: (1) expedite the reemployment of individuals who establish initial eligibility for unemployment compensation under state law, or (2) improve the effectiveness of a state in carrying out its state law with respect to reemployment."
      summary_should = "Helping Innovation of Re-Employment Services in States Act or HIRES Act - Amends title III (Grants to States for Unemployment Compensation Administration. Here is a second sentence to test against. And a third for good measure.) of the Social Security Act (SSA) to authorize the Secretary of Labor to enter into agreements with states to allow them to conduct demonstration projects to test and evaluate measures designed to: <br>(1) expedite the reemployment of individuals who establish initial eligibility for unemployment compensation under state law, or <br>(2) improve the effectiveness of a state in carrying out its state law with respect to reemployment."

      parse_summary(summary).should eq(summary_should)
    end
  end

  describe "split_voter_ids" do
    it "should return all votes for a legislation" do
    end
  end
end

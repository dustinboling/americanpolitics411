class LegislationController < ApplicationController
  def grab_xml
    require 'nokogiri'
    require 'open-uri'
    @doc = Nokogiri::XML(open("http://thomas.loc.gov/home/gpoxmlc112/s2002_is.xml")).remove_namespaces!
    
    @title = @doc.xpath('//title').map do |t|
      {'title' => t.xpath('//title').inner_text}
    end
    
    @date = @doc.xpath('//action-date').map do |date|
      {'action-date' => date.xpath('//action-date').inner_text}
    end
    
    @cosponsors = @doc.xpath('//cosponsor').map do |c|
      {'cosponsor' => c.xpath('//cosponsor').inner_text}
    end
    
    @sponsors = @doc.xpath('//sponsor').map do |s|
      {'sponsor' => s.xpath('//sponsor').inner_text}
    end
    
    @committee_names = @doc.xpath('//committee-name').map do |committee|
      {'committee-name' => committee.xpath('//committee-name').inner_text}
    end
    
    @body = @doc.xpath('//legis-body').map do |body|
      {'legis-body' => body.xpath('//legis-body').inner_text}
    end
    
  end
  
  def list
    
  end

end

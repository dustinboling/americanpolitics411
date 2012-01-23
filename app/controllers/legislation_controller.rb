class LegislationController < ApplicationController
  def grab_xml
    require 'nokogiri'
    require 'open-uri'
    
    @doc = Nokogiri::XML(open("http://thomas.loc.gov/home/gpoxmlc112/s2002_is.xml")).remove_namespaces!
    
    @title = @doc.xpath('//title').inner_text
    
    @date = @doc.xpath('//action-date').inner_text
    
    @congress = @doc.xpath('//congress').inner_text
    
    @session = @doc.xpath('//session').inner_text
    
    @legis_num = @doc.xpath('//legis-num').inner_text
  
    @sponsor = @doc.xpath('//sponsor').inner_text
    
    @cosponsors = @doc.xpath('//cosponsor').inner_text
    
    @committee_names = @doc.xpath('//committee-name').map do |committee|
      {'committee-name' => committee.xpath('//committee-name').inner_text}
    end
    
    @body = @doc.xpath('//legis-body').inner_text
    
  end
  
  def list
    
  end

end

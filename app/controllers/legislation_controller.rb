class LegislationController < ApplicationController
  def grab_xml
    require 'nokogiri'
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://thomas.loc.gov/home/gpoxmlc112/s2002_is.xml"))
    puts doc
  end
  
  def list
    
  end

end

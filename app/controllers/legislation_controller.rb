class LegislationController < ApplicationController
  def grab_xml
    require 'nokogiri'
    doc = Nokogiri::XML(open(http://thomas.loc.gov/home/gpoxmlc112/s2002_is.xml))
  end
  
  def list
    
  end

end

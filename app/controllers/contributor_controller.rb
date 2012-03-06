class ContributorController < ApplicationController
  
  layout 'admin'
  
  def show
    @contributions = TransparencyData::Client.contributions(:contributor_ft => params[:contributor_name], :cycle => [2006, 2007, 2008, 2009, 2010, 2011, 2012])
  end

end

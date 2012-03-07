class ContributorController < ApplicationController
  
  layout 'admin'
  
  def show
    if TransparencyData::Client.entities(:search => params[:contributor_name]).empty? || params[:entity_type] == "I"
      # do nothing
    else
      @entity = TransparencyData::Client.entities(:search => params[:contributor_name])
      @id = @entity.first.id
      @sectors = TransparencyData::Client.top_sectors(@id)
    end
    @contributions = TransparencyData::Client.contributions(:contributor_ft => params[:contributor_name], :cycle => [2006, 2007, 2008, 2009, 2010, 2011, 2012])
  end
end
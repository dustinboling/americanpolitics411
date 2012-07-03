class SubcommitteesController < ApplicationController
  
  layout 'public'
  
  def index
    @subcommittees = Subcommittee.order("chamber ASC", "name ASC")
  end

  def show
    @subcommittee = Subcommittee.find(params[:id])
  end

end

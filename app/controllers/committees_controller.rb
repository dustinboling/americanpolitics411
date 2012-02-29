class CommitteesController < ApplicationController
  
  layout 'admin'
  
  def index
    @committees = Committee.order('name ASC')
  end
  
  def show
    @committee = Committee.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @committee }
    end
  end

end

class CommitteesController < ApplicationController
  
  layout 'admin'
  
  def index
    # @committees = Committee.order('name ASC')
    @house_committees = Committee.where("name like 'House%'")
    @senate_committees = Committee.where("name like 'Senate%'")
    @joint_committees = Committee.where("name like 'Joint%'")
  end
  
  def show
    @committee = Committee.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @committee }
    end
  end

end

class CommitteesController < ApplicationController

  layout 'admin'

  def index
    @house_committees = Committee.where("name like 'House%'")
    @senate_committees = Committee.where("name like 'Senate%'")
    @joint_committees = Committee.where("name like 'Joint%'")
  end

  def manage
    @committees = Committee.order('name ASC')
  end

  def show
    @committee = Committee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @committee }
    end
  end

  def edit
    @committee = Committee.find(params[:id])
  end

  def update
    @committee = Committee.find(params[:id])

    respond_to do |format|
      if @committee.update_attributes(params[:committee])
        format.html {
          flash[:notice] = "#{@committee.name} has been updated successfully." 
          redirect_to :action => 'manage'
        }
      else
        format.html { render action: 'edit' }
      end
    end
  end

end

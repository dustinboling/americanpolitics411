class LegislationController < ApplicationController
  
  require 'open-uri'
  
  layout 'admin'
  
  def index
    list
    render('list')
  end
  
  def new
    @legislation = Legislation.new
  end
  
  def show
    if params[:bill_number]
      @legislation = Legislation.find_by_bill_number(params[:bill_number])
    else
      @legislation = Legislation.find(params[:id])
    end 
  end
  
  def edit
    @legislation = Legislation.find(params[:id])
  end
  
  def list
    @legislations = Legislation.order('bill_number ASC')
  end
  
  def update
    @legislation = Legislation.find(params[:id])
    
    respond_to do |format|
      if @legislation.update_attributes(params[:legislation])
        format.html { 
          flash[:notice] = 'Legislation has been successfully updated.'
          render 'edit'  }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @legislation.errors, status: :unprocessable_entity }
      end
    end
  end

end

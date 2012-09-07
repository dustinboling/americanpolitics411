class LegislationController < ApplicationController

  layout 'public'

  def index
    @legislation = Legislation.order('introduced_date DESC').page(params[:page]).per(25).includes(:passage_votes)
  end

  def refresh
    if params[:legislations][:introduced_year]
      year = params[:legislations][:introduced_year]
      @legislation = Legislation.where("introduced_year = ?", "#{year}").page(params[:page]).per(25)
    elsif params[:legislations][:session]
      congress_year = params[:legislations][:session]
      @legislation = Legislation.where(:session => congress_year).page(params[:page]).per(25)
    elsif params[:legislations][:issue_name]
      issue = Issue.find_by_name(params[:legislations][:issue_name])
      li = LegislationIssue.where(:issue_id => issue.id).includes(:legislation)
      @legislation = []
      li.each do |l|
        @legislation << l.legislation
      end
      @legislation = Kaminari.paginate_array(@legislation).page(params[:page]).per(25)
    end

    respond_to do |format|
      format.js
    end
  end

  def search
    if params[:legislations][:introduced_year]
      year = params[:legislations][:introduced_year]
      @legislation = Legislation.where("introduced_year = ?", "#{year}").page(params[:page]).per(25)
    elsif params[:legislations][:session]
      congress_year = params[:legislations][:session]
      @legislation = Legislation.where(:session => congress_year).page(params[:page]).per(25)
    elsif params[:legislations][:issue_name]
      issue = Issue.find_by_name(params[:legislations][:issue_name])
      li = LegislationIssue.where(:issue_id => issue.id).includes(:legislation)
      @legislation = []
      li.each do |l|
        @legislation << l.legislation
      end
      @legislation = Kaminari.paginate_array(@legislation).page(params[:page]).per(25)
    end
  end

  def show
    if params[:bill_number]
      @legislation = Legislation.find_by_bill_number(params[:bill_number]).includes(:legislation_issues)
      get_votes
    else
      @legislation = Legislation.find(params[:id])
      get_votes
    end 
  end

  def list
    @legislation = Legislation.order('introduced_date DESC').page(params[:page]).per(25)
  end

  def new
    @legislation = Legislation.new
  end

  def edit
    @legislation = Legislation.find(params[:id])
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


  private

  def get_votes
    client = Congress::Client.new
    @votes = client.votes(:bill_id => @legislation.rtc_id)

    return @votes
  end
end

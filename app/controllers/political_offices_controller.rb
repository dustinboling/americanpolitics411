class PoliticalOfficesController < ApplicationController
  
  load_and_authorize_resource
  
  layout 'admin'
  
  # GET /political_offices
  # GET /political_offices.json
  def index
    @political_offices = PoliticalOffice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @political_offices }
    end
  end

  # GET /political_offices/1
  # GET /political_offices/1.json
  def show
    @political_office = PoliticalOffice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @political_office }
    end
  end

  # GET /political_offices/new
  # GET /political_offices/new.json
  def new
    @political_office = PoliticalOffice.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @political_office }
    end
  end

  # GET /political_offices/1/edit
  def edit
    @political_office = PoliticalOffice.find(params[:id])
  end

  # POST /political_offices
  # POST /political_offices.json
  def create
    @political_office = PoliticalOffice.new(params[:political_office])

    respond_to do |format|
      if @political_office.save
        format.html { redirect_to @political_office, notice: 'Political office was successfully created.' }
        format.json { render json: @political_office, status: :created, location: @political_office }
      else
        format.html { render action: "new" }
        format.json { render json: @political_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /political_offices/1
  # PUT /political_offices/1.json
  def update
    @political_office = PoliticalOffice.find(params[:id])

    respond_to do |format|
      if @political_office.update_attributes(params[:political_office])
        format.html { redirect_to @political_office, notice: 'Political office was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @political_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /political_offices/1
  # DELETE /political_offices/1.json
  def destroy
    @political_office = PoliticalOffice.find(params[:id])
    @political_office.destroy

    respond_to do |format|
      format.html { redirect_to political_offices_url }
      format.json { head :ok }
    end
  end
end

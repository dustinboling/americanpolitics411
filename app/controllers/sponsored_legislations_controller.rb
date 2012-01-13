class SponsoredLegislationsController < ApplicationController
  
  layout 'admin'
  
  # GET /sponsored_legislations
  # GET /sponsored_legislations.json
  def index
    @sponsored_legislations = SponsoredLegislation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sponsored_legislations }
    end
  end

  # GET /sponsored_legislations/1
  # GET /sponsored_legislations/1.json
  def show
    @sponsored_legislation = SponsoredLegislation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sponsored_legislation }
    end
  end

  # GET /sponsored_legislations/new
  # GET /sponsored_legislations/new.json
  def new
    @sponsored_legislation = SponsoredLegislation.new
    @people = Person.order('id ASC')
    @person = Person.find_by_id(params[:person_id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sponsored_legislation }
    end
  end

  # GET /sponsored_legislations/1/edit
  def edit
    @sponsored_legislation = SponsoredLegislation.find(params[:id])
  end

  # POST /sponsored_legislations
  # POST /sponsored_legislations.json
  def create
    @sponsored_legislation = SponsoredLegislation.new(params[:sponsored_legislation])

    respond_to do |format|
      if @sponsored_legislation.save
        format.html { redirect_to @sponsored_legislation, notice: 'Sponsored legislation was successfully created.' }
        format.json { render json: @sponsored_legislation, status: :created, location: @sponsored_legislation }
      else
        format.html { render action: "new" }
        format.json { render json: @sponsored_legislation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sponsored_legislations/1
  # PUT /sponsored_legislations/1.json
  def update
    @sponsored_legislation = SponsoredLegislation.find(params[:id])

    respond_to do |format|
      if @sponsored_legislation.update_attributes(params[:sponsored_legislation])
        format.html { redirect_to @sponsored_legislation, notice: 'Sponsored legislation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @sponsored_legislation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsored_legislations/1
  # DELETE /sponsored_legislations/1.json
  def destroy
    @sponsored_legislation = SponsoredLegislation.find(params[:id])
    @sponsored_legislation.destroy

    respond_to do |format|
      format.html { redirect_to sponsored_legislations_url }
      format.json { head :ok }
    end
  end
end

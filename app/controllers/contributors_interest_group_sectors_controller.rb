class ContributorsInterestGroupSectorsController < ApplicationController
  
  layout 'admin'
  
  # GET /contributors_interest_group_sectors
  # GET /contributors_interest_group_sectors.json
  def index
    @contributors_interest_group_sectors = ContributorsInterestGroupSector.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contributors_interest_group_sectors }
    end
  end

  # GET /contributors_interest_group_sectors/1
  # GET /contributors_interest_group_sectors/1.json
  def show
    @contributors_interest_group_sector = ContributorsInterestGroupSector.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contributors_interest_group_sector }
    end
  end

  # GET /contributors_interest_group_sectors/new
  # GET /contributors_interest_group_sectors/new.json
  def new
    @contributors_interest_group_sector = ContributorsInterestGroupSector.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contributors_interest_group_sector }
    end
  end

  # GET /contributors_interest_group_sectors/1/edit
  def edit
    @contributors_interest_group_sector = ContributorsInterestGroupSector.find(params[:id])
  end

  # POST /contributors_interest_group_sectors
  # POST /contributors_interest_group_sectors.json
  def create
    @contributors_interest_group_sector = ContributorsInterestGroupSector.new(params[:contributors_interest_group_sector])

    respond_to do |format|
      if @contributors_interest_group_sector.save
        format.html { redirect_to @contributors_interest_group_sector, notice: 'Contributors interest group sector was successfully created.' }
        format.json { render json: @contributors_interest_group_sector, status: :created, location: @contributors_interest_group_sector }
      else
        format.html { render action: "new" }
        format.json { render json: @contributors_interest_group_sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contributors_interest_group_sectors/1
  # PUT /contributors_interest_group_sectors/1.json
  def update
    @contributors_interest_group_sector = ContributorsInterestGroupSector.find(params[:id])

    respond_to do |format|
      if @contributors_interest_group_sector.update_attributes(params[:contributors_interest_group_sector])
        format.html { redirect_to @contributors_interest_group_sector, notice: 'Contributors interest group sector was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @contributors_interest_group_sector.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributors_interest_group_sectors/1
  # DELETE /contributors_interest_group_sectors/1.json
  def destroy
    @contributors_interest_group_sector = ContributorsInterestGroupSector.find(params[:id])
    @contributors_interest_group_sector.destroy

    respond_to do |format|
      format.html { redirect_to contributors_interest_group_sectors_url }
      format.json { head :ok }
    end
  end
end

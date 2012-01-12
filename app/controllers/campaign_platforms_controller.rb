class CampaignPlatformsController < ApplicationController
  
  layout 'admin'
  
  # GET /campaign_platforms
  # GET /campaign_platforms.json
  def index
    @campaign_platforms = CampaignPlatform.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campaign_platforms }
    end
  end

  # GET /campaign_platforms/1
  # GET /campaign_platforms/1.json
  def show
    @campaign_platform = CampaignPlatform.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @campaign_platform }
    end
  end

  # GET /campaign_platforms/new
  # GET /campaign_platforms/new.json
  def new
    @campaign_platform = CampaignPlatform.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campaign_platform }
    end
  end

  # GET /campaign_platforms/1/edit
  def edit
    @campaign_platform = CampaignPlatform.find(params[:id])
  end

  # POST /campaign_platforms
  # POST /campaign_platforms.json
  def create
    @campaign_platform = CampaignPlatform.new(params[:campaign_platform])

    respond_to do |format|
      if @campaign_platform.save
        format.html { redirect_to @campaign_platform, notice: 'Campaign platform was successfully created.' }
        format.json { render json: @campaign_platform, status: :created, location: @campaign_platform }
      else
        format.html { render action: "new" }
        format.json { render json: @campaign_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campaign_platforms/1
  # PUT /campaign_platforms/1.json
  def update
    @campaign_platform = CampaignPlatform.find(params[:id])

    respond_to do |format|
      if @campaign_platform.update_attributes(params[:campaign_platform])
        format.html { redirect_to @campaign_platform, notice: 'Campaign platform was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @campaign_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_platforms/1
  # DELETE /campaign_platforms/1.json
  def destroy
    @campaign_platform = CampaignPlatform.find(params[:id])
    @campaign_platform.destroy

    respond_to do |format|
      format.html { redirect_to campaign_platforms_url }
      format.json { head :ok }
    end
  end
end

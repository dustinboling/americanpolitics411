class PersonalAssetsController < ApplicationController
  
  load_and_authorize_resource
  
  layout 'admin'
  
  # GET /personal_assets
  # GET /personal_assets.json
  def index
    @personal_assets = PersonalAsset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @personal_assets }
    end
  end

  # GET /personal_assets/1
  # GET /personal_assets/1.json
  def show
    @personal_asset = PersonalAsset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @personal_asset }
    end
  end

  # GET /personal_assets/new
  # GET /personal_assets/new.json
  def new
    @personal_asset = PersonalAsset.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')
    @organizations = Organization.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @personal_asset }
    end
  end

  # GET /personal_assets/1/edit
  def edit
    @personal_asset = PersonalAsset.find(params[:id])
  end

  # POST /personal_assets
  # POST /personal_assets.json
  def create
    @personal_asset = PersonalAsset.new(params[:personal_asset])

    respond_to do |format|
      if @personal_asset.save
        format.html { redirect_to @personal_asset, notice: 'Personal asset was successfully created.' }
        format.json { render json: @personal_asset, status: :created, location: @personal_asset }
      else
        format.html { render action: "new" }
        format.json { render json: @personal_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /personal_assets/1
  # PUT /personal_assets/1.json
  def update
    @personal_asset = PersonalAsset.find(params[:id])

    respond_to do |format|
      if @personal_asset.update_attributes(params[:personal_asset])
        format.html { redirect_to @personal_asset, notice: 'Personal asset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @personal_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_assets/1
  # DELETE /personal_assets/1.json
  def destroy
    @personal_asset = PersonalAsset.find(params[:id])
    @personal_asset.destroy

    respond_to do |format|
      format.html { redirect_to personal_assets_url }
      format.json { head :ok }
    end
  end
end

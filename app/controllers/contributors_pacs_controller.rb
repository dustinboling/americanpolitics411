class ContributorsPacsController < ApplicationController
  
  load_and_authorize_resource
  
  layout 'admin'
  
  # GET /contributors_pacs
  # GET /contributors_pacs.json
  def index
    @contributors_pacs = ContributorsPac.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contributors_pacs }
    end
  end

  # GET /contributors_pacs/1
  # GET /contributors_pacs/1.json
  def show
    @contributors_pac = ContributorsPac.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contributors_pac }
    end
  end

  # GET /contributors_pacs/new
  # GET /contributors_pacs/new.json
  def new
    @contributors_pac = ContributorsPac.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contributors_pac }
    end
  end

  # GET /contributors_pacs/1/edit
  def edit
    @contributors_pac = ContributorsPac.find(params[:id])
  end

  # POST /contributors_pacs
  # POST /contributors_pacs.json
  def create
    @contributors_pac = ContributorsPac.new(params[:contributors_pac])

    respond_to do |format|
      if @contributors_pac.save
        format.html { redirect_to @contributors_pac, notice: 'Contributors pac was successfully created.' }
        format.json { render json: @contributors_pac, status: :created, location: @contributors_pac }
      else
        format.html { render action: "new" }
        format.json { render json: @contributors_pac.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contributors_pacs/1
  # PUT /contributors_pacs/1.json
  def update
    @contributors_pac = ContributorsPac.find(params[:id])

    respond_to do |format|
      if @contributors_pac.update_attributes(params[:contributors_pac])
        format.html { redirect_to @contributors_pac, notice: 'Contributors pac was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @contributors_pac.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributors_pacs/1
  # DELETE /contributors_pacs/1.json
  def destroy
    @contributors_pac = ContributorsPac.find(params[:id])
    @contributors_pac.destroy

    respond_to do |format|
      format.html { redirect_to contributors_pacs_url }
      format.json { head :ok }
    end
  end
end

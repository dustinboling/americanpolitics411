class ContributorsController < ApplicationController
  
  load_and_authorize_resource
  
  layout 'admin'
  
  # GET /contributors
  # GET /contributors.json
  def index
    @contributors = Contributor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contributors }
    end
  end
  
  def show
    
  end

  # GET /contributors/1
  # GET /contributors/1.json
  def search_contributor
    @contributions = TransparencyData::Client.contributions(
      :contributor_ft => params[:contributor_name],
      :cycle => 2011
      )

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contributor }
    end
  end

  # GET /contributors/new
  # GET /contributors/new.json
  def new
    @contributor = Contributor.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')
    @organizations = Organization.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contributor }
    end
  end

  # GET /contributors/1/edit
  def edit
    @contributor = Contributor.find(params[:id])
  end

  # POST /contributors
  # POST /contributors.json
  def create
    @contributor = Contributor.new(params[:contributor])

    respond_to do |format|
      if @contributor.save
        format.html { redirect_to @contributor, notice: 'Contributor was successfully created.' }
        format.json { render json: @contributor, status: :created, location: @contributor }
      else
        format.html { render action: "new" }
        format.json { render json: @contributor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contributors/1
  # PUT /contributors/1.json
  def update
    @contributor = Contributor.find(params[:id])

    respond_to do |format|
      if @contributor.update_attributes(params[:contributor])
        format.html { redirect_to @contributor, notice: 'Contributor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @contributor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributors/1
  # DELETE /contributors/1.json
  def destroy
    @contributor = Contributor.find(params[:id])
    @contributor.destroy

    respond_to do |format|
      format.html { redirect_to contributors_url }
      format.json { head :ok }
    end
  end
end

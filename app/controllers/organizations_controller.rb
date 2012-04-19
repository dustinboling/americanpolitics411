class OrganizationsController < ApplicationController
  
  load_and_authorize_resource
  skip_authorize_resource :only => :show
  
  layout 'admin'
  
  def autocomplete_organization_name
    @organizations = Organization.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @organizations.map(&:name)
  end
  
  def index
    @organizations = Organization.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /organizations/1
  def show
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /organizations/new
  def new
    @organization = Organization.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
  end

  # POST /organizations
  def create
    @organization = Organization.new(params[:organization])

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /organizations/1
  def update
    @organization = Organization.find(params[:id])

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :ok }
    end
  end
end

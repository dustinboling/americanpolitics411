class BusinessAssociatesController < ApplicationController
  
  load_and_authorize_resource
  
  layout 'admin'
  
  # GET /business_associates
  # GET /business_associates.json
  def index
    @business_associates = BusinessAssociate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @business_associates }
    end
  end

  # GET /business_associates/1
  # GET /business_associates/1.json
  def show
    @business_associate = BusinessAssociate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business_associate }
    end
  end

  # GET /business_associates/new
  # GET /business_associates/new.json
  def new
    @business_associate = BusinessAssociate.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')
    @organizations = Organization.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business_associate }
    end
  end

  # GET /business_associates/1/edit
  def edit
    @business_associate = BusinessAssociate.find(params[:id])
  end

  # POST /business_associates
  # POST /business_associates.json
  def create
    @business_associate = BusinessAssociate.new(params[:business_associate])

    respond_to do |format|
      if @business_associate.save
        format.html { redirect_to @business_associate, notice: 'Business associate was successfully created.' }
        format.json { render json: @business_associate, status: :created, location: @business_associate }
      else
        format.html { render action: "new" }
        format.json { render json: @business_associate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /business_associates/1
  # PUT /business_associates/1.json
  def update
    @business_associate = BusinessAssociate.find(params[:id])

    respond_to do |format|
      if @business_associate.update_attributes(params[:business_associate])
        format.html { redirect_to @business_associate, notice: 'Business associate was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @business_associate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_associates/1
  # DELETE /business_associates/1.json
  def destroy
    @business_associate = BusinessAssociate.find(params[:id])
    @business_associate.destroy

    respond_to do |format|
      format.html { redirect_to business_associates_url }
      format.json { head :ok }
    end
  end
end

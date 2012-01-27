class LitigationsController < ApplicationController
  
  load_and_authorize_resource
  
  layout 'admin'
  
  # GET /litigations
  # GET /litigations.json
  def index
    @litigations = Litigation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @litigations }
    end
  end

  # GET /litigations/1
  # GET /litigations/1.json
  def show
    @litigation = Litigation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @litigation }
    end
  end

  # GET /litigations/new
  # GET /litigations/new.json
  def new
    @litigation = Litigation.new
    @people = Person.order('id ASC')
    @person = Person.find_by_id(params[:person_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @litigation }
    end
  end

  # GET /litigations/1/edit
  def edit
    @litigation = Litigation.find(params[:id])
  end

  # POST /litigations
  # POST /litigations.json
  def create
    @litigation = Litigation.new(params[:litigation])

    respond_to do |format|
      if @litigation.save
        format.html { redirect_to @litigation, notice: 'Litigation was successfully created.' }
        format.json { render json: @litigation, status: :created, location: @litigation }
      else
        format.html { render action: "new" }
        format.json { render json: @litigation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /litigations/1
  # PUT /litigations/1.json
  def update
    @litigation = Litigation.find(params[:id])

    respond_to do |format|
      if @litigation.update_attributes(params[:litigation])
        format.html { redirect_to @litigation, notice: 'Litigation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @litigation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /litigations/1
  # DELETE /litigations/1.json
  def destroy
    @litigation = Litigation.find(params[:id])
    @litigation.destroy

    respond_to do |format|
      format.html { redirect_to litigations_url }
      format.json { head :ok }
    end
  end
end

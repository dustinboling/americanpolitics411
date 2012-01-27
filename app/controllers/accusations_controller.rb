class AccusationsController < ApplicationController
  
  load_and_authorize_resource
  before_filter :require_login
  
  layout 'admin'
  
  # GET /accusations
  # GET /accusations.json
  def index
    @accusations = Accusation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accusations }
    end
  end

  # GET /accusations/1
  # GET /accusations/1.json
  def show
    @accusation = Accusation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @accusation }
    end
  end

  # GET /accusations/new
  # GET /accusations/new.json
  def new
    @accusation = Accusation.new
    @people = Person.order('id ASC')
    @person = Person.find_by_id(params[:person_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accusation }
    end
  end

  # GET /accusations/1/edit
  def edit
    @accusation = Accusation.find(params[:id])
  end

  # POST /accusations
  # POST /accusations.json
  def create
    @accusation = Accusation.new(params[:accusation])

    respond_to do |format|
      if @accusation.save
        format.html { redirect_to @accusation, notice: 'Accusation was successfully created.' }
        format.json { render json: @accusation, status: :created, location: @accusation }
      else
        format.html { render action: "new" }
        format.json { render json: @accusation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accusations/1
  # PUT /accusations/1.json
  def update
    @accusation = Accusation.find(params[:id])

    respond_to do |format|
      if @accusation.update_attributes(params[:accusation])
        format.html { redirect_to @accusation, notice: 'Accusation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @accusation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accusations/1
  # DELETE /accusations/1.json
  def destroy
    @accusation = Accusation.find(params[:id])
    @accusation.destroy

    respond_to do |format|
      format.html { redirect_to accusations_url }
      format.json { head :ok }
    end
  end
end

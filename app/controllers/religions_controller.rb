class ReligionsController < ApplicationController

  load_and_authorize_resource
  skip_authorize_resource :only => :show

  layout 'public'

  def autocomplete_religion_name
  end

  # GET /religions
  def index
    @religions = Religion.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /religions/1
  def show
    @religion = Religion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /religions/new
  def new
    @religion = Religion.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /religions/1/edit
  def edit
    @religion = Religion.find(params[:id])
  end

  # POST /religions
  def create
    @religion = Religion.new(params[:religion])

    respond_to do |format|
      if @religion.save
        format.html { redirect_to @religion, notice: 'Religion was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /religions/1
  def update
    @religion = Religion.find(params[:id])

    respond_to do |format|
      if @religion.update_attributes(params[:religion])
        format.html { redirect_to @religion, notice: 'Religion was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /religions/1
  def destroy
    @religion = Religion.find(params[:id])
    @religion.destroy

    respond_to do |format|
      format.html { redirect_to religions_url }
    end
  end
end

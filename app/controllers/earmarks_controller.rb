class EarmarksController < ApplicationController
  
  load_and_authorize_resource
  
  layout 'admin'
  
  # GET /earmarks
  # GET /earmarks.json
  def index
    @earmarks = Earmark.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @earmarks }
    end
  end

  # GET /earmarks/1
  # GET /earmarks/1.json
  def show
    @earmark = Earmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @earmark }
    end
  end

  # GET /earmarks/new
  # GET /earmarks/new.json
  def new
    @earmark = Earmark.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')
    @organizations = Organization.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @earmark }
    end
  end

  # GET /earmarks/1/edit
  def edit
    @earmark = Earmark.find(params[:id])
  end

  # POST /earmarks
  # POST /earmarks.json
  def create
    @earmark = Earmark.new(params[:earmark])

    respond_to do |format|
      if @earmark.save
        format.html { redirect_to @earmark, notice: 'Earmark was successfully created.' }
        format.json { render json: @earmark, status: :created, location: @earmark }
      else
        format.html { render action: "new" }
        format.json { render json: @earmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /earmarks/1
  # PUT /earmarks/1.json
  def update
    @earmark = Earmark.find(params[:id])

    respond_to do |format|
      if @earmark.update_attributes(params[:earmark])
        format.html { redirect_to @earmark, notice: 'Earmark was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @earmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /earmarks/1
  # DELETE /earmarks/1.json
  def destroy
    @earmark = Earmark.find(params[:id])
    @earmark.destroy

    respond_to do |format|
      format.html { redirect_to earmarks_url }
      format.json { head :ok }
    end
  end
end

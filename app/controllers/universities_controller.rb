class UniversitiesController < ApplicationController
  
  load_and_authorize_resource  
  
  layout 'admin'
  
  before_filter :find_person
  
  # GET /universities
  # GET /universities.json
  def index
    @universities = University.find(:all)
  end
  
  def autocomplete_university_name
    @universities = University.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @universities.map(&:name)
  end
  
  def list
    @universities = University.sorted.where(:person_id => @person.id)
  end

  # GET /universities/1
  # GET /universities/1.json
  def show
    @universities = University.find(params[:id])
    @university = University.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @university }
    end
  end

  # GET /universities/new
  # GET /universities/new.json
  def new
    @university = University.new
    @universities = University.order('id ASC')
    @people = Person.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @university }
    end
  end

  # GET /universities/1/edit
  def edit
    @university = University.find(params[:id])
  end

  # POST /universities
  # POST /universities.json
  def create
    @university = University.new(params[:university])

    respond_to do |format|
      if @university.save
        format.html { redirect_to @university, notice: 'University was successfully created.' }
        format.json { render json: @university, status: :created, location: @university }
      else
        format.html { render action: "new" }
        format.json { render json: @university.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /universities/1
  # PUT /universities/1.json
  def update
    @university = University.find(params[:id])

    respond_to do |format|
      if @university.update_attributes(params[:university])
        format.html { redirect_to @university, notice: 'University was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @university.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /universities/1
  # DELETE /universities/1.json
  def destroy
    @university = University.find(params[:id])
    @university.destroy

    respond_to do |format|
      format.html { redirect_to universities_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def find_person
    if params[:person_id]
      @person = Person.find_by_id(params[:person_id])
    end
  end
  
end

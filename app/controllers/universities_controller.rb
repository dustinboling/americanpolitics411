class UniversitiesController < ApplicationController
  
  load_and_authorize_resource
  skip_authorize_resource :only => :show
  
  layout 'public'
  
  before_filter :find_person
  
  def index
    @universities = University.find(:all)
  end
  
  def list
    @universities = University.sorted.where(:person_id => @person.id)
  end

  def show
    @universities = University.find(params[:id])
    @university = University.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @university }
    end
  end

  def new
    @university = University.new
    @universities = University.order('id ASC')
    @people = Person.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @university }
    end
  end

  def edit
    @university = University.find(params[:id])
  end

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

  def destroy
    @university = University.find(params[:id])
    if Degree.where("university_id = ?", "#{params[:id]}").empty?
      @university.destroy
    else
      flash[:error] = "Cannot delete a university while it is attached to a person"
    end

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

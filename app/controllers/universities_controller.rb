class UniversitiesController < ApplicationController

  layout 'admin'
  
  before_filter :find_person
  
  def index
    list
    render('list')
  end
  
  def list
    @universities = University.sorted.where(:person_id => @person.id)
  end
  
  def show
    @universities = University.find(params[:id])
    @university = University.find(params[:id])
  end
  
  def new
    @university = University.new
    @universities = University.order('id ASC')
    @people = Person.order('id ASC')
  end
  
  def create
    # instantiates new object
    @university = University.new(params[:university])
    # save the object
    if @university.save
      # if save succeeds, redirect to the list action
      flash[:notice] = "University created."
      redirect_to(:controller => 'people', :action => 'index')
    else
      # if save fails, redisplay form
      render('new')
    end
  end
  
  def edit
   @university = University.find(params[:id])
  end
  
  def update
    # find object
    @university = University.find(params[:id])
    # update object
    if @university.update_attributes(params[:id])
      # if update succeeds, redirect to list action
      flash[:notice] = "University updated."
    else
      # If update fails redisplay form
      render('edit')
    end
  end
  
  def delete
    @university = University.find(params[:id])    
  end
  
  def destroy
    University.find(params[:id]).destroy
    flash[:notice] = "Page destroyed."
    redirect_to(:action => 'list')
  end
  
  private
  
  def find_person
    if params[:person_id]
      @person = Person.find_by_id(params[:person_id])
    end
  end

  
end

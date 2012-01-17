class PeopleController < ApplicationController
  
  before_filter :require_login
  
  layout 'admin'
  
  # GET /all
  # GET /all.json
  def all
    @people = Person.order("people.id ASC")
    
    respond_to do |format|
      format.html # all.html.erb
      format.json { render json: @people}
      format.xml { render xml: @people }
    end
  end
  
  # GET /people
  # GET /people.json
  def index
    @people = Person.order("people.id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
      format.xml {render xml: @people }
    end
  end
  
  def list
    @people = People.order("people.id ASC")
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
    @degrees = Degree.find :all
  

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new
    @religions = Religion.order('id ASC')
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
    @people = Person.order('id ASC')
    @religions = Religion.order('id ASC')
    @organizations = Organization.order('id ASC')
    @universities = University.order('id ASC')
    
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])
    @religions = Religion.find :all


    respond_to do |format|
      if @person.save
        format.html { redirect_to :action => 'edit', :id => @person.id, :notice => 'Person added successfully' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to :action => 'edit', :id => @person.id }
        flash[:notice] = "#{@person.full_name} has been updated"
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :ok }
    end
  end
end

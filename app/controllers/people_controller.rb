class PeopleController < ApplicationController
  
  load_and_authorize_resource
  skip_authorize_resource :only => [:all, :representatives, :senators, :indiv_contributors, :pac_contributors, :autocomplete_person_name, :autocomplete_person_url]
  
  layout 'admin'
  
  def autocomplete_person_name
    @people = Person.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @people.map(&:name)
  end
  
  def autocomplete_person_url
    @people = Person.order(:slug).where("slug like ?", "%#{params[:term]}%")
    render json: @people.collect { |p| { :label => "#{p.first_name} #{p.last_name}", :value => p.slug } }
  end
  
  def senators
    @people = Person.where("chamber = 'S'").order("people.last_name ASC")
  end
  
  def representatives
    @people = Person.where("chamber = 'H'").order("people.last_name ASC")
  end
  
  # GET /all
  # GET /all.json
  def all
    @people = Person.order("people.id ASC")
    
    respond_to do |format|
      format.html # all.html.erb
      format.json { render :json => @people}
      format.xml { render xml: @people }
    end
  end
  
  # GET /people
  # GET /people.json
  def index
    render 'all'
  end
  
  def list
    @people = People.order("people.id ASC")
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
    
    # Load necessary information from the various APIs
    @pac_contributors = TransparencyData::Client.contributions(
      :recipient_ft => "#{Person.find_by_id(params[:id]).first_name} #{Person.find_by_id(params[:id]).last_name}", 
      :cycle => 2011, 
      :amount => {:gte => 2300},
      :contributor_type => "C")
    @individual_contributors = TransparencyData::Client.contributions(
        :recipient_ft => "#{Person.find_by_id(params[:id]).first_name} #{Person.find_by_id(params[:id]).last_name}", 
        :cycle => 2011, 
        :amount => {:gte => 2300},
        :contributor_type => "I")
    # sectors
    @entity = TransparencyData::Client.entities(:search => "#{@person.first_name} #{@person.last_name}")
    @id = @entity.first.id
    @sectors = TransparencyData::Client.top_sectors(@id)
    
    # Get most recent tweets
    unless @person.twitter_id.blank?
      begin
        @recent_tweets = Twitter.user_timeline("#{@person.twitter_id}").take(10)
      rescue Exception => e
        case e.message
          when /Twitter is over capacity/
            @recent_tweets = Twitter.user_timeline("#{@person.twitter_id}").take(10)
        end
      end
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  def pac_contributors
    @person = Person.find_by_id(params[:id])
    @pac_contributors = TransparencyData::Client.contributions(
      :recipient_ft => "#{Person.find_by_id(params[:id]).first_name} #{Person.find_by_id(params[:id]).last_name}", 
      :cycle => 2011, 
      :amount => {:gte => 2300},
      :contributor_type => "C")
  end
  
  def indiv_contributors
    @person = Person.find_by_id(params[:id])
    @individual_contributors = TransparencyData::Client.contributions(
        :recipient_ft => "#{Person.find_by_id(params[:id]).first_name} #{Person.find_by_id(params[:id]).last_name}", 
        :cycle => 2011, 
        :amount => {:gte => 1000},
        :contributor_type => "I")
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
    @religions = Religion.order('name ASC')
    @organizations = Organization.order('name ASC')
    @universities = University.order('name ASC')    
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { 
          flash[:notice] = 'Person added successfully.'
          redirect_to(:action => 'edit', :id => @person.id)
          }
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
    @people = Person.all
    @religions = Religion.order('name ASC')
    @organizations = Organization.find (:all)
    @universities = University.find(:all)

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { 
          flash[:notice] = 'Person has been successfully updated.'
          render 'edit'  }
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
      format.html { 
        flash[:notice] = "Person removed."
        redirect_to root_url
        }
      format.json { head :ok }
    end
  end
end

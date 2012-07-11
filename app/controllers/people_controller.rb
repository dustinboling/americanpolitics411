class PeopleController < ApplicationController

  layout 'public'

  load_and_authorize_resource
  skip_authorize_resource :only => [:all, :representatives, :senators, 
    :indiv_contributors, :pac_contributors, :autocomplete_person_name, 
    :autocomplete_person_url, :refresh_officials, 
    :switch_to_representative_by_state, :switch_to_representative_by_name, 
    :switch_to_representative_by_party, :switch_to_senator_by_state, 
    :switch_to_senator_by_name, :switch_to_senator_by_party]

  # populate list of names for autocomplete
  def autocomplete_person_name
    @people = Person.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @people.map(&:name)
  end

  # populate list of urls for autocomplete  
  def autocomplete_person_url
    @people = Person.order(:slug).where("slug like ?", "%#{params[:term]}%")
    render json: @people.collect { |p| { :label => "#{p.first_name} #{p.last_name}", :value => p.slug } }
  end

  def all
    @people = Person.order("people.id ASC")

    respond_to do |format|
      format.html # all.html.erb
      format.json { render :json => @people}
      format.xml { render xml: @people }
    end
  end

  def senators
    @people = Person.where("chamber = 'S'").order("people.last_name ASC")
  end

  def representatives
    @people = []
  end

  def switch_to_representative_by_state
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def switch_to_representative_by_name
    respond_to do |format|
      format.js { render :layout => false }
    end 
  end

  def switch_to_representative_by_party
    respond_to do |format|
      format.js { render :layout => false }
    end 
  end

  def switch_to_senator_by_state
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
  
  def switch_to_senator_by_name
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def switch_to_senator_by_state
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def get_professional_experience_text
    respond_to do |format|
      format.js { render :layout => false }
    end 
  end

  def refresh_officials
    if params.has_key?(:state) && params.has_key(:chamber)
      @people = Person.where(:current_state => params[:state], :chamber => params[:chamber])
    elsif params.has_key?(:name) && params.has_key?(:chamber)
      name_range  = params[:name].split('-')
      @people = Person.where("chamber = '#{params[:chamber]}' AND last_name BETWEEN '#{name_range[0]}' AND '#{name_range[1]}'")
    elsif params.has_key?(:chamber) && params.has_key?(:party)
      @people = Person.where(:chamber => params[:chamber], :current_party => params[:party])
    elsif params.has_key?(:state)
      @people = Person.where(:current_state => params[:state])
    elsif params.has_key?(:party)
      @people = Person.where(:current_party => params[:party])
    elsif params.has_key?(:chamber)
      @people = Person.where(:chamber => params[:chamber])
    end

    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def index
    render 'all'
  end

  def list
    @people = People.order("people.id ASC")
  end

  def show
    @person = Person.find(params[:id])

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
    @person = Person.find(params[:id])
    @pac_contributors = TransparencyData::Client.contributions(
      :recipient_ft => "#{@person.remove_name_numericality}", 
      :cycle => 2011, 
      :amount => {:gte => 2300},
      :contributor_type => "C")
  end

  def indiv_contributors
    @person = Person.find(params[:id])
    @individual_contributors = TransparencyData::Client.contributions(
      :recipient_ft => "#{@person.remove_name_numericality}", 
      :cycle => 2011, 
      :amount => {:gte => 1000},
      :contributor_type => "I")
  end

  def new
    @person = Person.new
    @religions = Religion.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

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

  def update
    @person = Person.find(params[:id])

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

class ProfessionalExperiencesController < ApplicationController
  # GET /professional_experiences
  # GET /professional_experiences.json
  def index
    @professional_experiences = ProfessionalExperience.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @professional_experiences }
    end
  end

  # GET /professional_experiences/1
  # GET /professional_experiences/1.json
  def show
    @professional_experience = ProfessionalExperience.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @professional_experience }
    end
  end

  # GET /professional_experiences/new
  # GET /professional_experiences/new.json
  def new
    @professional_experience = ProfessionalExperience.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')
    @organizations = Organization.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @professional_experience }
    end
  end

  # GET /professional_experiences/1/edit
  def edit
    @professional_experience = ProfessionalExperience.find(params[:id])
  end

  # POST /professional_experiences
  # POST /professional_experiences.json
  def create
    @professional_experience = ProfessionalExperience.new(params[:professional_experience])

    respond_to do |format|
      if @professional_experience.save
        format.html { redirect_to @professional_experience, notice: 'Professional experience was successfully created.' }
        format.json { render json: @professional_experience, status: :created, location: @professional_experience }
      else
        format.html { render action: "new" }
        format.json { render json: @professional_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /professional_experiences/1
  # PUT /professional_experiences/1.json
  def update
    @professional_experience = ProfessionalExperience.find(params[:id])

    respond_to do |format|
      if @professional_experience.update_attributes(params[:professional_experience])
        format.html { redirect_to @professional_experience, notice: 'Professional experience was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @professional_experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /professional_experiences/1
  # DELETE /professional_experiences/1.json
  def destroy
    @professional_experience = ProfessionalExperience.find(params[:id])
    @professional_experience.destroy

    respond_to do |format|
      format.html { redirect_to professional_experiences_url }
      format.json { head :ok }
    end
  end
end

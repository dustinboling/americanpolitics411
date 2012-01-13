class ContributorsInterestGroupsController < ApplicationController
  
  layout 'admin'

  # GET /contributors_interest_groups
  # GET /contributors_interest_groups.json
  def index
    @contributors_interest_groups = ContributorsInterestGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contributors_interest_groups }
    end
  end

  # GET /contributors_interest_groups/1
  # GET /contributors_interest_groups/1.json
  def show
    @contributors_interest_group = ContributorsInterestGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contributors_interest_group }
    end
  end

  # GET /contributors_interest_groups/new
  # GET /contributors_interest_groups/new.json
  def new
    @contributors_interest_group = ContributorsInterestGroup.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contributors_interest_group }
    end
  end

  # GET /contributors_interest_groups/1/edit
  def edit
    @contributors_interest_group = ContributorsInterestGroup.find(params[:id])
  end

  # POST /contributors_interest_groups
  # POST /contributors_interest_groups.json
  def create
    @contributors_interest_group = ContributorsInterestGroup.new(params[:contributors_interest_group])

    respond_to do |format|
      if @contributors_interest_group.save
        format.html { redirect_to @contributors_interest_group, notice: 'Contributors interest group was successfully created.' }
        format.json { render json: @contributors_interest_group, status: :created, location: @contributors_interest_group }
      else
        format.html { render action: "new" }
        format.json { render json: @contributors_interest_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contributors_interest_groups/1
  # PUT /contributors_interest_groups/1.json
  def update
    @contributors_interest_group = ContributorsInterestGroup.find(params[:id])

    respond_to do |format|
      if @contributors_interest_group.update_attributes(params[:contributors_interest_group])
        format.html { redirect_to @contributors_interest_group, notice: 'Contributors interest group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @contributors_interest_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributors_interest_groups/1
  # DELETE /contributors_interest_groups/1.json
  def destroy
    @contributors_interest_group = ContributorsInterestGroup.find(params[:id])
    @contributors_interest_group.destroy

    respond_to do |format|
      format.html { redirect_to contributors_interest_groups_url }
      format.json { head :ok }
    end
  end
end

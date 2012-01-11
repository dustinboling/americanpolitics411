class FlipFlopsController < ApplicationController
  
  layout 'admin'
  
  # GET /flip_flops
  # GET /flip_flops.json
  def index
    @flip_flops = FlipFlop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flip_flops }
    end
  end

  # GET /flip_flops/1
  # GET /flip_flops/1.json
  def show
    @flip_flop = FlipFlop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flip_flop }
    end
  end

  # GET /flip_flops/new
  # GET /flip_flops/new.json
  def new
    @flip_flop = FlipFlop.new
    @person = Person.find_by_id(params[:person_id])
    @people = Person.order('id ASC')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flip_flop }
    end
  end

  # GET /flip_flops/1/edit
  def edit
    @flip_flop = FlipFlop.find(params[:id])
  end

  # POST /flip_flops
  # POST /flip_flops.json
  def create
    @flip_flop = FlipFlop.new(params[:flip_flop])

    respond_to do |format|
      if @flip_flop.save
        format.html { redirect_to @flip_flop, notice: 'Flip-flop was successfully created.' }
        format.json { render json: @flip_flop, status: :created, location: @flip_flop }
      else
        format.html { render action: "new" }
        format.json { render json: @flip_flop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /flip_flops/1
  # PUT /flip_flops/1.json
  def update
    @flip_flop = FlipFlop.find(params[:id])

    respond_to do |format|
      if @flip_flop.update_attributes(params[:flip_flop])
        format.html { redirect_to @flip_flop, notice: 'Flip-flop was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @flip_flop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flip_flops/1
  # DELETE /flip_flops/1.json
  def destroy
    @flip_flop = FlipFlop.find(params[:id])
    @flip_flop.destroy

    respond_to do |format|
      format.html { redirect_to flip_flops_url }
      format.json { head :ok }
    end
  end
end

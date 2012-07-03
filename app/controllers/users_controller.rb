class UsersController < ApplicationController

  load_and_authorize_resource

  layout 'public'

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        opts = {:user_id => current_user.id,
          :resource_type => params[:controller].singularize,
          :resource_id => @user.id,
          :action => params[:action]}
        Activity.create(opts)

        format.html { redirect_to @user, :notice => 'User has been successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

end

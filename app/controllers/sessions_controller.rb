class SessionsController < ApplicationController
  
  layout 'public'
  
  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:notice] = "Email or password incorrect."
      render :new
    end
  end
  
  def destroy
    logout
    flash[:notice] = "Logged out"
    redirect_to root_url
  end
end

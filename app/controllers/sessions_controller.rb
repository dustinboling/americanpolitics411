class SessionsController < ApplicationController
  
  layout 'admin'
  
  def new
  end

  def create
    user = login(params[:username], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Email or password incorrect."
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => "Logged out"
  end
end

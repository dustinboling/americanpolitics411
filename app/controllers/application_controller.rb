class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You do not have permission to access this page."
    redirect_to root_url
  end
  
  private
  
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
end
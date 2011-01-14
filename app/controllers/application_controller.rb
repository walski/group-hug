class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller

  protect_from_forgery
  
  def current_user
    current_facebook_user
  end
  
  helper_method :current_user
  
  
  def login_required
    if current_user.nil?
      flash[:notice] = "You must login to access this page"
      session[:return_to] = request.request_uri
      redirect_to :controller =>'home', :action =>'login' and return
    end
  end
end

class HomeController < ApplicationController
  
  before_filter :login_required, :except => [:login]

  
  def index 
    @pages = current_facebook_user.accounts
  end

  def login
  end

end

class HomeController < ApplicationController
   
  def login
  end

  def create
    @user = User.find_by_email(params[:email])
    create_via_facebook_connect if @user.nil?

    if @user != nil 
      session[:user_id] = @user.id
      redirect_to session[:return_to]||url_for(groups_path)
      session[:return_to]=nil
    else
      flash[:error] = "Unable to log you in"
      render :action=>"login"
    end
  end

  def create_via_facebook_connect
    if current_facebook_user 
      #look for an existing user
      @user = User.find_by_facebook_id(current_facebook_user.id)	  
      if @user.nil?
        #if one isn't found - fetch user data via Mogli lib and create new user
        current_facebook_user.fetch
	    @user = User.new(:name => current_facebook_user[:name], :email => current_facebook_user[:email], :facebook_id => current_facebook_user[:id], :facebook_session_key => current_facebook_client.access_token)
		@user.save
      end
    end
  end

  end

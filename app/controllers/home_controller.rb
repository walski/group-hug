class HomeController < ApplicationController
  
  before_filter :login_required, :except => [:login, :create]

  
  def index 
    #@pages = []
    @groups = current_facebook_user.groups
    @group = Mogli::Group.new({:id=>'138671229525345'}, current_facebook_client)
	#@group.client = current_facebook_client
	@group.fetch
	#puts @group.feed.inspect
	@posts = @group.feed
	#//puts @group.fetch().inspect
  end

  def show_posts
  
    @group = Mogli::Group.new({:id=>'138671229525345'}, current_facebook_client)
	@posts = @group.feed
  end

  def login
  end

def create
    @user = User.find_by_email(params[:email])
    create_via_facebook_connect if @user.nil?
    if @user
      session[:user_id] = @user.id
    end
    if current_user
      redirect_to session[:return_to]||url_for(groups_path)
      session[:return_to]=nil
    else
      flash[:error] = "Unable to log you in"
      render :action=>"login"
    end
  end

  def create_via_facebook_connect
    puts current_facebook_user.inspect
    if current_facebook_user
      #look for an existing user
      @user = User.find_by_facebook_id(current_facebook_user.id)	  
      if @user.nil?
        #if one isn't found - creating new user
        current_facebook_user.fetch
	    user = User.new(:name => current_facebook_user[:name], :email => current_facebook_user[:email], :facebook_id => current_facebook_user[:id], :facebook_session_key => current_facebook_client.access_token)
		user.save
      end
    end
  end

  end

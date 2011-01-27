class GroupsController < ApplicationController

  before_filter :login_required

  def index 
    #get current users groups
    @groups = current_facebook_user.groups
	
	#determine selected user group or get first group id if default group is not selected
	@default_group = @current_user.default_group
	@default_group = @groups.first.id if @default_group.nil? && @groups.first != nil
  end

  def default
	render :json => { :result => @current_user.update_attributes(:default_group => params['id'] == 'nil' ? nil : params['id']) }
  end

  end

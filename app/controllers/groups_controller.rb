class GroupsController < ApplicationController

  before_filter :login_required

  def index 
    @groups = current_facebook_user.groups
  end

end

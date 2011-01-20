class PostsController < ApplicationController

  before_filter :login_required

  def index    
    @group = Mogli::Group.new({:id=>params['group_id']}, current_facebook_client)
	@group.fetch
	@posts = @group.feed
	render :layout => false
  end
  
  def new
    @group = Mogli::Group.new({:id=>params['group_id']}, current_facebook_client)
	@group.fetch
  end

  def create
    puts params.inspect
	
    @group = Mogli::Group.new({:id=>params['group_id']}, current_facebook_client)
	@group.fetch
	#@posts = @group.feed

    #flash[:notice] = "Note sent to #{note.recipient.email}"
    if current_facebook_user
	  puts current_facebook_client.class.post(current_facebook_client.api_path(@group.id + '/feed'),
			:query=>current_facebook_client.default_params.merge(
			           {:name => "#{current_facebook_user.name} Post a message using app!",
                        :link=>'http://staging.operations.engineyard.com/groups',
                        :message=>params['message']})).inspect
    end
    redirect_to groups_path	
  end
end

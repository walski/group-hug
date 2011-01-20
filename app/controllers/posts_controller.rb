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
	puts current_facebook_client.class.get(current_facebook_client.api_path('me/feed'),:query=>current_facebook_client.default_params).inspect
	#@posts = @group.feed

    #flash[:notice] = "Note sent to #{note.recipient.email}"
    if current_facebook_user
	current_facebook_user.fetch
      current_facebook_user.feed_create(
        Mogli::Post.new(:name => "#{current_facebook_user.name} Post a message using app!",
                        :link=>url_for(groups_path),
                        :description=>params['message']))
    end
    redirect_to notes_path	
  end
end

class StaticPagesController < ApplicationController
  
  # GET /
  def home
    if signed_in? then
      @wallpost = current_user.wallposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
      @sub_items = current_user.subscription_feed.paginate(page: params[:page], per_page: 10)
    end
  end

  # GET /help
  def help
  end
  
  # GET /about
  def about
  end
  
  # GET /contact
  def contact
  end
  
end

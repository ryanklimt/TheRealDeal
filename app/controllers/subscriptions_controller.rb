class SubscriptionsController < ApplicationController
  
  before_action :signed_in_user
  
  respond_to :html, :js
  
  def create
    @subforum = Subforum.find(params[:subscription][:subforum_id])
    current_user.subscribe!(@subforum)
    respond_with @subforum.forum
  end

  def destroy
    @subforum = Subscription.find(params[:id]).subforum
    current_user.unsubscribe!(@subforum)
    respond_with @subforum
  end
end

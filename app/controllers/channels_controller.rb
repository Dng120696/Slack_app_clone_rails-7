class ChannelsController < ApplicationController
def show
  @channel = current_user.channels.find(params[:id])
  @message = @channel.messages.new
   @messages = @channel.messages



end

end

class MessagesController < ApplicationController

  def create
    @channel = current_user.channels.find(params[:channel_id])
    @message = @channel.messages.new(message_params)
    @message.user = current_user
    if @message.save
      ActionCable.server.broadcast  "chatroom_channel", {mod_message: message_render(@message)}
    else
     @messages = @channel.messages # Retrieve messages for the view
      render 'channels/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
      render(partial:'message',locals:{message: message})
  end
end

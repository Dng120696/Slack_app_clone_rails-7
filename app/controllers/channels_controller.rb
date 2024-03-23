class ChannelsController < ApplicationController

def index

end
def show
  @channel = current_user.channels.find(params[:id])
  @message = @channel.messages.new
  @messages = @channel.messages
end

def new
  @channel = current_user.channels.new
end

def create
  @channel = current_user.channels.create(channel_params)

  if @channel.save
    redirect_to root_path, notice: 'Successfully Created a Channel.'
  else
    render :new
  end
end

def add_users
  @channel = Channel.find(params[:id])
  user_ids = Array(params[:user_ids])

  if @channel.users << User.where(id: user_ids)
    redirect_to @channel, notice: "Users added to channel successfully."
  else
    redirect_to @channel, alert: "Failed to add users to channel."
  end
end

def destroy
  @channel = current_user.channels.find(params[:id])
  @channel.destroy
end
# def add_user
#   @channel = Channel.find(params[:id])
#   @user = User.find(params[:user_id])

#   if @channel.users << @user
#     redirect_to @channel, notice: "User added to channel successfully."
#   else
#     redirect_to @channel, alert: "Failed to add user to channel."
#   end
# end
private

def channel_params
  params.require(:channel).permit(:name)
end


end

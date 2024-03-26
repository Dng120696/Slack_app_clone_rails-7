class ChannelsController < ApplicationController

def index
  @channels = current_user.channels
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
  respond_to do |format|
    if @channel.save
      format.html{ redirect_to root_path,  notice: 'Successfully Created a Channel.'}
      format.turbo_stream{ render :create, locals: {channel: @channel}}

    else
      format.html{ redirect_to :new,  status: :unprocessable_entity}
      format.turbo_stream{ render :new, status: :unprocessable_entity, locals: {channel: @channel}}
    end
  end
end

def add_users
  @channel = Channel.find(params[:id])
  user_ids = Array(params[:user_ids])

  existing_user_ids = @channel.user_ids
  new_user_ids = user_ids - existing_user_ids

  if new_user_ids.present?
    @channel.users << User.where(id: new_user_ids)
    redirect_to @channel, notice: "Users added to channel successfully."
  else
    redirect_to @channel, alert: "No more users to add."
  end
end

def destroy
  @channel = current_user.channels.find(params[:id])
  @channel.destroy
  redirect_to root_path
end

private

def channel_params
  params.require(:channel).permit(:name)
end


end

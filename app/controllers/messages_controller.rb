class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    @message.save
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end
  

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end


# def edit
#   @message = Message.new
# end

# def update
#   room = Room.find(params[:room_id])
#   @message = @room.messages.new(message_params)
#   if message.update
#     redirect_to :edit
#   else
#     render :edit(edit.html.erbを見せる)
#   end
# end

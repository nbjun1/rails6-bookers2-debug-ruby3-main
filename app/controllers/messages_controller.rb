class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show]

  def index
    @users = User.all
  end

  def show
    @received_messages = current_user.received_messages
    @sent_messages = current_user.sent_messages

  end

  def create
    @message = current_user.sent_messages.build(message_params)
    @message.save
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:message, :receiver_id)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show]

  def index
    @received_messages = current_user.received_messages.includes(:sender)
    @sent_messages = current_user.sent_messages.includes(:receiver)
  end

  def show
    @received_messages = current_user.received_messages
    @sent_messages = current_user.sent_messages
    @message = Message.new

  end

  def create
    @newmessage = current_user.sent_messages.build(message_params)
    @newmessage.save
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:message, :receiver_id)
  end

  def set_message
    @message = Message.find_by(id: params[:id])
  end
end

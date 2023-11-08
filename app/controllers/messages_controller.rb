class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @reciver = User.find(params[:id])
    #@messages = current_user.messages_between(@reciver)
  end

  def create
    @recipient = User.find(params[:recipient_id])
    @message = current_user.send_message(@recipient, params[:content])

    respond_to do |format|
      format.js
    end
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end
end

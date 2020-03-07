class MessagesController < ApplicationController
  def create
    @message = Message.create message_params
    if @message.save

    else
      flash[:error] = "Tin nhan khoi tao that bai"
    end
  end


  private

  def message_params
    params.require(:message).permit Message::PARAMS
  end
end

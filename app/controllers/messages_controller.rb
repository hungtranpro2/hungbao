class MessagesController < ApplicationController
before_action :authenticate_user!

  def show
    @message = Message.find(params[:id])
    @file_name = @message.file_name
    @file_split = @message.file_name.split('.')
    send_file Rails.root.join('public', 'uploads', @file_name), type: "application/png", x_sendfile: true
  end

  def create
    uploaded_to = params[:message][:file_name]
    File.open(Rails.root.join('public', 'uploads', uploaded_to.original_filename), 'wb') do |file|
      file.write(uploaded_to.read)
    end
    @file_name = uploaded_to.original_filename;
    @message = Message.create message_params.merge(file_name: @file_name)
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

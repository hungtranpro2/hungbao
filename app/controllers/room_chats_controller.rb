class RoomChatsController < ApplicationController
before_action :authenticate_user!
  def index
    @message = Message.new

    @group_chats = current_user.list_messages.uniq
    @group_chat = current_user.list_messages.first
    @messages = @group_chat.messages.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @item_active = 1

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @message = Message.new

    @group_chats = current_user.list_messages.uniq
    @group_chat = ListMessage.find_by id: params[:id]
    @messages = @group_chat.messages.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @item_active = params[:id].to_i

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end

  def create

  end

end

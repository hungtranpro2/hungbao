class RoomChatsController < ApplicationController

  def index
    @message = Message.new

    @group_chats = current_user.list_messages.uniq
    @group_chat = current_user.list_messages.first
    @item_active = 1
  end

  def show
    @message = Message.new

    @group_chats = current_user.list_messages.uniq
    @group_chat = ListMessage.find_by id: params[:id]
    @item_active = params[:id].to_i
  end

  def new
  end

  def create

  end

end

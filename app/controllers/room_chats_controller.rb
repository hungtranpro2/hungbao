class RoomChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @message = Message.new
    @group_chats = current_user.list_messages.uniq
    @group_chat = current_user.list_messages.where(type_mes: 2).first
    @messages = @group_chat.messages.where(user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
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
    if @group_chat.blank?
      redirect_to errors_path
    else
      if @group_chat.my_chat?
        @messages = @group_chat.messages.where(user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      else
        @messages = @group_chat.messages.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      end
      @item_active = params[:id].to_i

      respond_to do |format|
        format.html
        format.js
      end
    end
  end
end

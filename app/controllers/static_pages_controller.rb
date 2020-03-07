class StaticPagesController < ApplicationController
  def index
  	@group_chats = current_user.list_messages.uniq
    @group_default = current_user.list_messages.first
    @item_active = 1
  end

  def new

  end

  def create
  end

end

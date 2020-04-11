class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    .paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end
end

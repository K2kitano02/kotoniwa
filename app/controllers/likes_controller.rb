class LikesController < ApplicationController
  before_action :require_login
  def create
    @post = Post.find(params[:post_id])
    # いいねが存在しない場合は作成、存在する場合は取得
    current_user.likes.find_or_create_by(post: @post)
    redirect_to request.referer || post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.likes.find_by(post: @post)&.destroy
    redirect_to request.referer || post_path(@post)
  end
end

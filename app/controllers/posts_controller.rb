class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :require_login, only: %i[new create edit update destroy]
  before_action :authorize_post_owner, only: %i[edit update destroy]
  def index
    @posts = Post.public_post.order(created_at: :desc)
    @posts = @posts.where(category: params[:category]) if params[:category].present? && Post.categories.key?(params[:category])
    # 検索欄に何か入ってる時のみ検索する。
    if params[:q].present?
      # 必ず文字列にする #.string.stripで空白を削除
      q = "%#{params[:q].to_s.strip}%"
      @posts = @posts.where("title ILIKE :q OR body ILIKE :q OR work_name ILIKE :q", q: q)
    end
  end
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿を作成しました"
    else
      render :new, status: :unprocessable_entity
      flash.now[:alert] = "投稿の作成に失敗しました"
    end
  end

  def show
    unless @post.is_public? || (current_user && @post.user_id == current_user.id)
      redirect_to posts_path, alert: "指定の投稿は表示できません"
      return
    end
    # 同じカテゴリーの投稿を2件取得（今の投稿と、遷移元の投稿は除外）
    relation = Post.public_post.where(category: @post.category).where.not(id: @post.id)
    relation = relation.where.not(id: params[:from]) if params[:from].present?
    @related_posts = relation.order(created_at: :desc).limit(2)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました"
    else
      render :edit, status: :unprocessable_entity
      flash.now[:alert] = "投稿の更新に失敗しました"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private
  def set_post #一件一件取得し共通化
    @post = Post.find(params[:id])
  end

  def authorize_post_owner
    return if @post.user_id == current_user.id
    redirect_to posts_path, alert: "投稿の編集権限がありません"
  end

  def post_params
    params.require(:post).permit(:title, :body, :work_name, :category, :is_public)
  end
end

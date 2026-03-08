class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    redirect_to login_path, alert: "ログインが必要です" unless current_user
  end

  def like_by_current_user?(post)
    return false unless current_user
    current_user.likes.exists?(post_id: post.id)
  end
  helper_method :like_by_current_user?
end

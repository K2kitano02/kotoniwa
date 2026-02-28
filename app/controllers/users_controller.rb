class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :require_login, only: %i[edit update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "ユーザーを作成しました"
    else
      flash.now[:alert] = "ユーザーの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "ユーザーを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

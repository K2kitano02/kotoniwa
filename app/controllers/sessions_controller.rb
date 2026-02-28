class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user&.authenticate(params[:password])
      reset_session ##セッション固定攻撃対策
      session[:user_id] = @user.id
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています"
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end

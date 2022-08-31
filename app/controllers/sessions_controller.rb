class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
  end

  def create
    #binding.pry
    user = login(params[:session][:email],params[:session][:password])
      if user
        if user.user_stopflag == false
          #binding.pry
          user.update(user_logintime: Time.now)
          redirect_to root_path, notice: 'ログインしました'
        elsif user.user_stopflag == true
          logout
          redirect_to new_user_path, notice: '新規登録して下さい'
        else
          flash[:alert] = 'ログイン失敗'
          render :new
        end
      end
  end

  def reject_user
    @user
  end
  
  def destroy
    logout
    redirect_to login_path, notice: "ログアウトしました"
  end
end

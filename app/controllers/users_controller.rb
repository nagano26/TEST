class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      @user.update!(user_logintime: Time.now, user_stopflag: false)
      redirect_to root_path, notice:"登録完了しました！ログインして下さい！"
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
    unless current_user
      redirect_to root_path, notice:"不正アクセスです"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = user_params
    if params[:back] || !@user.valid?(:edit)
       render 'edit'
    else
      @user.save!(context: :edit)
      redirect_to user_path(@user), notice: "更新致しました"
    end
  end

  def confirm_edit
    #binding.pry
    @user = User.find(params[:user_id])
    @user.attributes = user_params
    render :edit if @user.invalid?(:edit)
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update!(user_stopflag: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(
     :username,
     :username_kana,
     :email,
     :password,
     :password_confirmation,
    ) 
  end
end

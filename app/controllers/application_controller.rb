class ApplicationController < ActionController::Base
  before_action :require_login

  protected

  def not_authenticated
      redirect_to login_path, danger: "ログインしてください"
  end
end

class HomeController < ApplicationController
  def index
    if params[:latest]
      @orders = Order.where(user_id: current_user.id).latest.page(params[:page]).per(3)
    elsif params[:old]
      @orders = Order.where(user_id: current_user.id).old.page(params[:page]).per(3)
    else
      @orders = Order.where(user_id: current_user.id).page(params[:page]).per(3)
    end
  end
end

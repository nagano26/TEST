class OrdersController < ApplicationController
  def index
    #binding.pry
    @orders = Order.where(user_id: current_user.id).page(params[:page]).per(5)
  end

  def new
    @order = Order.new
  end

  def create
    ActiveRecord::Base.transaction do
     @order = Order.new(order_params)
     @product = Product.find(order_params[:product_id])
     #binding.pry
     @product.product_zaiko = @product.product_zaiko-@order.order_number
     @product.product_stopflag = 1 if @product.product_zaiko == 0 
     if !@order.valid? || !@product.valid?
       @product.product_zaiko = Product.find(order_params[:product_id]).product_zaiko
       render template: "products/show"
     elsif params[:back]
       render template: "products/show"
     else    
       #binding.pry
        @product.save!
        @order.save!
        @user = User.find(order_params[:user_id])
        UserMailer.create_email(@user).deliver
        redirect_to complete_orders_path, notice:"登録しました"
     end
    end
  end

  def show
    @order = Order.find(params[:id])
    @order = Order.page(params[:page]).per(5)
  end

  def edit
  end
  
  def confirm_new
      logger.debug params.inspect
      logger.debug "order confirm_new"
      #binding.pry
      @order = Order.new(order_params)
      @product = Product.find(order_params[:product_id])
      render template: "products/show" unless @order.valid?
  end

  def complete 
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :product_id, :order_number, :order_sumprice)
  end
end

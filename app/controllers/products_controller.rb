class ProductsController < ApplicationController
  before_action :session_check, only: [:index]
  
  def index
    if params[:latest]
      @products = Product.where.not(product_zaiko: 0).and(Product.where.not(product_stopflag: 1))
      @products = @products.latest.old.page(params[:page]).per(5)
    elsif params[:old]
      @products = Product.where.not(product_zaiko: 0).and(Product.where.not(product_stopflag: 1))
      @products = @products.old.page(params[:page]).per(5)
    else
      @products = Product.where.not(product_zaiko: 0).and(Product.where.not(product_stopflag: 1)) 
      @products = @products.page(params[:page]).per(5)
    end
    #binding.pry
  end

  def show
    logger.debug params.inspect
    logger.debug "prpduct show"
    @product = Product.find(params[:id])
    @order = Order.new
  end

  def search
    if params[:clear].present?
      session[:previous_url] = nil
      redirect_to products_path
      return
    end

    #binding.pry
    #キーワード検索
    if params[:keyword].present? 
      @products = Product.search(params[:keyword])
    else
      @products = Product.all
    end
  
    #在庫検索
    if params[:from].present? or params[:to].present?
     #binding.pry
      @products = @products.zaiko_search(params[:from].to_i, params[:to].to_i) 
    end
    
    #値段検索
    if params[:from_price].present? or params[:to_price].present?
      @products = @products.price_search(params[:from_price].to_i, params[:to_price].to_i)
    end

    #在庫切れ含む&販売停止を含む
    if params[:add_zaiko] == "1" && params[:add_stopflag] == "0"
      #binding.pry
      @products = @products.where.not(product_stopflag: 1)
    elsif params[:add_zaiko] == "0" && params[:add_stopflag] == "1"
      @products = @products.where.not(product_zaiko: 0)
    elsif params[:add_zaiko] == "1" && params[:add_stopflag] == "1"
      @products = @products.all
    else
      @products = @products.where.not(product_zaiko: 0).and(@products.where.not(product_stopflag: 1))
    end
      @products = @products.page(params[:page]).per(5)
    
      session[:previous_url] = request.url
    #binding.pry
    render "index"
  end

  private
  def session_check
    if session[:previous_url].present?
      logger.debug session[:previous_url]
      redirect_to session[:previous_url]
      #binding.pry
    end
  end
end

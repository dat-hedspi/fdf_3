class ProductsController < ApplicationController
  before_action :logged_in_user, :normal_user?, only: [:show, :index]
  
  def show
    session[:return_to] ||= request.referer
    @category = Category.all
    @product = Product.find_by id: params[:id]
    @rate = Rate.new
    @votes = Rate.votes
    @order_detail = current_order.order_details.new
    if @product.nil?
      flash[:danger] = t "flash.prod_nil"
      redirect_to products_path
    end
  end

  def index
    @order_detail = current_order.order_details.new
    @products = if params[:order] && params[:direction]
      order_prod Product
    elsif params[:direction]
      order_prod_rate Product
    else
      order_prod_default Product
    end
  end
end

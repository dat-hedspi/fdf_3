class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index]
  
  def show
    @category = Category.all
    @product = Product.find_by_id params[:id]
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
      Product.order_by(check_column(params[:order]), check_direction(params[:direction]))
    elsif params[:direction]
      Product.order_by_rate check_direction params[:direction]
    else
      Product.all
    end
  end
end

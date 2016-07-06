class CategoriesController < ApplicationController
  before_action :logged_in_user, :normal_user?, :store_locate,
    only: [:show, :index]

  def show
    @category = Category.find_by id: params[:id]
    @order_detail = current_order.order_details.new
    if @category.nil?
      flash[:danger] = t "flash.cate_nil"
      redirect_to categories_path
    else
      @products = if params[:order] && params[:direction]
        order_prod @category.products
      elsif params[:direction]
        order_prod_rate @category.products
      else
        order_prod_default @category.products
      end
    end
  end

  def index
    @categories = Category.all.order_by_name
    @order_detail = current_order.order_details.new
    @products = if params[:order] && params[:direction]
      order_prod Product
    elsif params[:direction]
      order_prod_rate Product
    else
      order_prod_default Product
    end
  end

  private
  def store_locate
    if session[:return_to]
      session.delete(:return_to)
    end
    session[:return_to] ||= request.url if request.get?
  end
end

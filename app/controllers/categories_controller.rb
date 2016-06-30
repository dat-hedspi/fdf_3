class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:show, :index]

  def show
    @category = Category.find_by_id params[:id]
    if @category.nil?
      flash[:danger] = t "flash.cate_nil"
      redirect_to categories_path
    else
      @products = if params[:order] && params[:direction]
        @category.products.order_by(check_column(params[:order]), check_direction(params[:direction]))
      elsif params[:direction]
        @category.products.order_by_rate check_direction params[:direction]
      else
        @category.products
      end
    end
  end

  def index
    @categories = Category.all.order_by_name
    @products = if params[:order] && params[:direction]
      Product.order_by(check_column(params[:order]), check_direction(params[:direction]))
    elsif params[:direction]
      Product.order_by_rate check_direction params[:direction]
    else
      Product.all
    end
  end
end

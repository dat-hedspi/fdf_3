class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:show, :index]

  def show
    @category = Category.find_by_id params[:id]
    if @category.nil?
      flash[:danger] = t "flash.cate_nil"
      redirect_to categories_path
    else
      @products = @category.products
    end
  end

  def index
    @categories = Category.all.order_by_name
    @products = Product.all
  end

end

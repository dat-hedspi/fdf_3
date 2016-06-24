class Admin::ProductsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  
  def index
    @products = Product.all.order_by_time
  end

  def new
    @product = Product.new
    @categories = Category.all.order_by_name
  end

  def create
    @product = Product.new product_params
    if @product.save
      @products = Product.all.order_by_time
      flash[:success] = t "productindex.success"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit :name, :description, 
      :price, :number, :category_id
  end
end

class Admin::ProductsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_product, only: [:edit, :update]

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

  def edit
    @categories = Category.all.order_by_name
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = t "productindex.update_success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  private
  def product_params
    params.require(:product).permit :name, :description, 
      :price, :number, :category_id
  end

  def find_product
    @product = Product.find_by_id params[:id]
    if @product.nil?
      flash[:danger] = t "flash.prod_nil"
      redirect_to products_path
    end
  end
end

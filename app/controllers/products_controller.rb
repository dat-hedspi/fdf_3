class ProductsController < ApplicationController
  def show
    @category = Category.all
    @product = Product.find_by_id params[:id]
    if @product.nil?
      flash[:danger] = t "flash.prod_nil"
      redirect_to products_path
    end
  end

  def index
    @products = Product.all
  end
end

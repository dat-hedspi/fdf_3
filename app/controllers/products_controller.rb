class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index]
  
  def show
    @category = Category.all
    @product = Product.find_by_id params[:id]
    @rate = Rate.new
    @votes = Rate.votes
    if @product.nil?
      flash[:danger] = t "flash.prod_nil"
      redirect_to products_path
    end
  end

  def index
    @products = Product.all
  end
end

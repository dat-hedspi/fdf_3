class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      @categories = Category.all
      flash[:success] = t "categoryindex.success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end

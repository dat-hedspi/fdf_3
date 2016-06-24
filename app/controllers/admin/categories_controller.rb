class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_category, except: [:index, :new, :create]

  def index
    @categories = Category.all.order_by_name
  end

  def new
    @category = Category.new
  end

  def show
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "categoryindex.update_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
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

  def destroy
    if @category.destroy
      flash[:success] = t "categoryindex.delete_success"
      redirect_to admin_categories_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def find_category
    @category = Category.find_by_id params[:id]
    if @category.nil?
      flash[:danger] = t "flash.cate_nil"
      redirect_to admin_categories_path
    end
  end
end

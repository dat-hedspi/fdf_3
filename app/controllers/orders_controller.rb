class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:show, :update, :index]
  before_action :check_prod_and_curren_order_exits, only: [:show, :update]
  def show
    @order_details = @order.order_details
  end

  def index
    @orders = Order.find_by user_id: current_user.id
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "order.ordered"
      redirect_to root_path
    end
    session.delete :order_id
    @current_order = nil
  end

  private
  def order_params
    params.require(:order).permit :status
  end

  def check_prod_and_curren_order_exits
    @order = Order.find_by id: session[:order_id]
    unless @order
      @order = Order.create user_id: current_user.id
      session[:order_id] = @order.id
    end
    if params[:order_detail]
      @product = Product.find_by id: params[:order_detail][:product_id]
      if @product.nil?
        flash[:danger] = t "flash.prod_nil"
        redirect_to root_path
      end
    end
  end
end

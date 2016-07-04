class OrdersController < ApplicationController
  before_action :logged_in_user, :check_prod_and_curren_order_exits, only: [:show]

  def show
    @order_details = @order.order_details
  end

  private
  def check_prod_and_curren_order_exits
    @order = Order.find_by id: session[:order_id]
    unless @order.present?
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

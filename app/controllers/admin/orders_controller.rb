class Admin::OrdersController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_order, only: [:edit, :update, :show]

  def edit
    @statuses = Order.statuses
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "order.update_succ"
      redirect_to admin_orders_path
    else
      render :edit
    end
  end

  def index
    if params[:status]
      @orders = Order.order_by_status check_status params[:status]
    else
      @orders = Order.order_by_status 1
    end
  end

  def show
    @order_details = @order.order_details
  end

  private
  def order_params
    params.require(:order).permit :status
  end

  def find_order
    @order = Order.find_by id: params[:id]
    if @order.nil?
      flash[:danger] = t "flash.order_nil"
      redirect_to admin_orders_path
    end
  end
end

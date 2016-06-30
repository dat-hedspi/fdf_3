class SessionsController < ApplicationController
  after_action :create_order, only: [:create]

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t "flash.session_create_e"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def create_order
    order = Order.create(status: 0, total_pay: 0,  user_id: current_user.id)
    session[:order_id] = order.id
  end
end

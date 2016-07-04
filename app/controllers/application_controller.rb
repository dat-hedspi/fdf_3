class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "login.danger"
      redirect_to login_url
    end
  end

  def verify_admin
    redirect_to root_path unless current_user.admins?
  end

  def check_column order
    Product.column_names.include?(order) ? order : t("filter.created_at")
  end
  
  def check_direction direction
    t("filter.asc") == direction ? t("filter.desc") : t("filter.asc")
  end

  def check_status status
    Order.statuses.values.include?(status.to_i) ? status : 1
  end
end

class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def index
    @users = User.paginate page: params[:page], per_page: Settings.size
  end

  def destroy
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to root_path
    end
    if @user.destroy
      flash[:success] = "User deleted"
      redirect_to admin_users_path
    end
  end

end

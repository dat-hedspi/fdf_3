class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin

  def index
    @users = User.paginate page: params[:page], per_page: Settings.size
  end

  def destroy
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to root_path
    else
      @user.destroy
      flash[:success] = t "user.deleted"
      redirect_to admin_users_path
    end
  end

end

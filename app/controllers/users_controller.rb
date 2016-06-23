class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to root_path
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile.update"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :address, :phone_number,
      :password
  end
  
  def correct_user
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to root_path
    end
    redirect_to root_url unless current_user? @user
  end

end

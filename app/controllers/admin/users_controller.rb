class Admin::UsersController < ApplicationController
skip_before_action :login_required, only: [:new, :create]
before_action :set_user, only: [:show,:update, :destroy]
  def index
    if current_user.role == "admin"
      @users = User.all
    else
      flash[:notice]="管理者以外はアクセスできない"
      redirect_to tasks_path
    end
  end
  def new
    if current_user.role == "admin"
      @user = User.new
    else
      flash[:notice]="管理者以外は新規管理者が作成できない"
      redirect_to tasks_path
    end
  end
  def create
    @user = User.create(admin_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end
  def edit
    if current_user.role == "admin"
      @user = User.find(params[:id])
    else
      flash[:notice]="管理者以外は編集できない"
      redirect_to tasks_path
    end
  end
  def update
    if @user.update(admin_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end
  def show
  end
  def destroy
    @user.destroy
    redirect_to admin_users_path
  end
  def set_user
    @user = User.find(params[:id])
  end
  def admin_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end

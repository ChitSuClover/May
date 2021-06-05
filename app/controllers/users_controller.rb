class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update]
  def new
    @user = User.new
  end
  def create
    if @user = User.create(user_params)
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  def show
    unless @user.id == current_user.id
      redirect_to tasks_path
    end
  end
  def set_user
  @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

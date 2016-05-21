class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @active_users   = User.active.all
    @inactive_users = User.inactive.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = t('created')
      redirect_to users_path
    else
      flash.now[:error] = t('error')
      render :new
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      redirect_to users_path, notice: t('updated')
    else
      redirect_to users_path, error: t('error')
    end
  end

  def destroy
    user = User.find(params[:id])
    if user != @current_user && user.update(deleted_at: Date.today)
      flash[:notice] = t('deleted')
    else
      flash[:error] = t('error')
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :deleted_at)
  end
end

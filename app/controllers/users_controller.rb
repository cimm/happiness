class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize @current_user
    @active_users   = User.active.all.order(:email)
    @inactive_users = User.inactive.all.order(:email)
  end

  def new
    authorize @current_user
    @user = User.new
  end

  def create
    authorize @current_user
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
    authorize @current_user
    user = User.find(params[:id])

    if user.update(user_params)
      redirect_to users_path, notice: t('updated')
    else
      redirect_to users_path, error: t('error')
    end
  end

  def destroy
    authorize @current_user
    user = User.find(params[:id])
    if user != @current_user && user.update(deleted_at: Date.today, admin: false)
      flash[:notice] = t('deleted')
    else
      flash[:error] = t('error')
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :deleted_at, :admin)
  end
end

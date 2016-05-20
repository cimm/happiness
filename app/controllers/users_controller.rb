class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def destroy
    user = User.find(params[:id])
    if user != @current_user && user.destroy
      flash[:notice] = t('deleted')
    else
      flash[:error] = t('deleted_error')
    end
    redirect_to users_path
  end
end

class SessionsController < ApplicationController
  def create
    @google_auth = request.env['omniauth.auth']

    if valid_auth_domain? && user = find_or_create_user
      session[:current_user_id] = user.id
      flash[:notice] = t('authenticated')
    else
      session[:current_user_id] = nil
      flash[:error] = t('not_authenticated')
    end
    redirect_to root_path
  end

  private

  def find_or_create_user
    User.find_by(uid: @google_auth.uid) || User.create(email: @google_auth.info.email, uid: @google_auth.uid)
  end

  def valid_auth_domain?
    @google_auth.info.email.include?('mymicroinvest.com')
  end
end

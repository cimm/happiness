class SessionsController < ApplicationController
  def create
    google_auth = request.env['omniauth.auth']

    if user = User.active.find_by_email(google_auth.info.email.downcase)
      session[:current_user_id] = user.id
      flash[:notice] = t('authenticated')
      redirect_to session[:previous_url] || root_path
    else
      session[:current_user_id] = nil
      not_authorized
    end
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :set_current_user

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protected

  def set_current_user
    @current_user = User.find_by_id(session[:current_user_id])
  end

  def authenticate_user!
    store_location
    redirect_to '/auth/google_oauth2' if @current_user.nil?
  end

  def store_location
    return unless request.get? || request.xhr?
    session[:previous_url] = request.fullpath
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def not_authorized
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

  def pundit_user
    @current_user
  end
end

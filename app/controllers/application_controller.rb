class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_current_employee

  protected

  def set_current_employee
    @current_employee = Employee.find_by_id(session[:current_employee_id])
  end
end

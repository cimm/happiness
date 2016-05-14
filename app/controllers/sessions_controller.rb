class SessionsController < ApplicationController
  def create
    @google_auth = request.env['omniauth.auth']

    if valid_auth_domain? && employee = find_or_create_employee
      session[:current_employee_id] = employee.id
      flash[:notice] = t('authenticated')
    else
      session[:current_employee_id] = nil
      flash[:error] = t('not_authenticated')
    end
    redirect_to root_path
  end

  private

  def find_or_create_employee
    Employee.find_by(uid: @google_auth.uid) || Employee.create(email: @google_auth.info.email, uid: @google_auth.uid)
  end

  def valid_auth_domain?
    @google_auth.info.email.include?('mymicroinvest.com')
  end
end

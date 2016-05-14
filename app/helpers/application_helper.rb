module ApplicationHelper
  def employee_authenticated?
    @current_employee.present?
  end
end

module ApplicationHelper
  def user_authenticated?
    @current_user.present?
  end
end

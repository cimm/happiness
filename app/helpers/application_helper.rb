module ApplicationHelper
  def user_authenticated?
    @current_user.present?
  end

  def colored_happiness_score(score)
    if score < 0
      klass = 'orange'
    elsif score > 0
      klass = 'olive'
    else
      klass = 'gray'
    end
    klass
  end
end

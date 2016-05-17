module ApplicationHelper
  def user_authenticated?
    @current_user.present?
  end

  def colored_happiness_score(score)
    if score == 0
      klass = 'gray'
    elsif score < 10
      klass = 'red'
    elsif score < 60
      klass = 'orange'
    elsif score >= 60
      klass = 'olive'
    end
    klass
  end
end

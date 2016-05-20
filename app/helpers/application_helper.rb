module ApplicationHelper
  GOOD_ENOUGH_SCORE = ENV.fetch('GOOD_ENOUGH_SCORE').to_i

  def user_authenticated?
    @current_user.present?
  end

  def colored_happiness_score(score)
    if score == 0
      klass = 'gray'
    elsif score < GOOD_ENOUGH_SCORE
      klass = 'red'
    elsif score >= GOOD_ENOUGH_SCORE
      klass = 'olive'
    end
    klass
  end
end

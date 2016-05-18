class SendSurveyService
  NUMBER_OF_RANDOM_QUESTIONS_PER_SURVEY = ENV.fetch('NUMBER_OF_RANDOM_QUESTIONS_PER_SURVEY').to_i

  def initialize(users)
    @survey = Survey.new
    @users  = users
  end

  def run
    Rails.logger.info 'Preparing new survey'
    @users.each do |user|
      Rails.logger.info "Sending survey to user ##{user.id}"
      create_answers_for_user(user)
      send_survey_for_user(user)
    end
    Rails.logger.info 'Done, going back to sleep.'
  end

  private

  def create_answers_for_user(user)
    questions.each do |question|
      user.answers.create(question: question, survey: @survey)
    end
  end

  def send_survey_for_user(user)
    SurveyMailer.new(@survey, user).deliver_later
  end

  def questions
    @questions ||= Question.fixed_regularity + Question.random_regularity.shuffle[0...NUMBER_OF_RANDOM_QUESTIONS_PER_SURVEY]
  end
end

class SendSurveyService
  NUMBER_OF_RANDOM_QUESTIONS_PER_SURVEY = ENV.fetch('NUMBER_OF_RANDOM_QUESTIONS_PER_SURVEY').to_i

  def initialize(users)
    @survey = Survey.new
    @users  = users
  end

  def run
    @users.each do |user|
      Rails.logger.info "Sending survey to user ##{user.id}"
      create_answers_for_user(user)
      send_survey_for_user(user)
    end
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

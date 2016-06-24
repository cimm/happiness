class SendSurveyService
  NUMBER_OF_FLEXIBLE_QUESTIONS_PER_SURVEY = ENV.fetch('NUMBER_OF_FLEXIBLE_QUESTIONS_PER_SURVEY').to_i

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
    @questions ||= Question.fixed_regularity + most_dated_flexible_questions
  end

  def most_dated_flexible_questions
    new_questions = Question.includes(:answers).flexible_regularity.select{ |q| q.answers.none? }

    asked_questions_ids = Answer.on_flexible_question.group(:question_id).maximum(:created_at).sort_by{ |_, created_at| created_at }.map(&:first)
    asked_questions = Question.find(asked_questions_ids).index_by(&:id).slice(*asked_questions_ids).values

    (new_questions + asked_questions).first(NUMBER_OF_FLEXIBLE_QUESTIONS_PER_SURVEY)
  end
end

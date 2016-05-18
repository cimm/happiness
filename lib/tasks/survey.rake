namespace :survey do
  SEND_SURVEY_AT_DAYS = ENV.fetch('SEND_SURVEY_AT_DAYS').split(',').map(&:to_i).uniq

  desc 'Check week day and send out a new survey'
  task daily_send: :environment do
    abort 'No users found' unless User.any?
    exit unless should_send_survey_today?

    SendSurveyService.new(User.all).run
  end

  def should_send_survey_today?
    SEND_SURVEY_AT_DAYS.include? Date.today.wday
  end
end

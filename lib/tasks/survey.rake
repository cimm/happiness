namespace :survey do
  desc 'Send out a new survey'
  task send: :environment do
    abort 'No users found' unless User.any?

    SendSurveyService.new(User.all).run
  end
end

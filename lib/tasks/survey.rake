namespace :survey do
  desc 'Send out a survey'
  task send: :environment do
    survey = Survey.generate
    survey.questions.each do |question|
      puts question.body
    end
  end
end

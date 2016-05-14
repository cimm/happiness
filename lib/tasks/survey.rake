namespace :survey do
  desc 'Send out a survey'
  task send: :environment do
    exit unless Employee.any?
    survey = Survey.generate
    survey.save!
    Employee.find_each do |employee|
      puts "Sending survey to #{employee.email}"
      SurveyMailer.new(survey, employee).deliver_later
    end
  end
end

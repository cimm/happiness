namespace :survey do
  desc 'Send out a survey'
  task send: :environment do
    survey = Survey.generate
    survey.save!
    Employee.find_each do |employee|
      puts "Sending survey to #{employee.email}"
      SurveyMailer.new(survey, employee).deliver_later
    end
  end
end

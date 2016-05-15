namespace :survey do
  desc 'Send out a survey'
  task send: :environment do
    exit unless Employee.any?

    survey = Survey.new
    questions = generate_question_set

    Employee.find_each do |employee|
      puts "Sending survey to #{employee.email}"

      questions.each do |question|
        Answer.create(employee: employee, question: question, survey: survey)
      end

      SurveyMailer.new(survey, employee).deliver_later
    end
  end

  def generate_question_set
    number_of_random_questions_per_survey = ENV.fetch('NUMBER_OF_RANDOM_QUESTIONS_PER_SURVEY').to_i
    Question.fixed_regularity + Question.random_regularity.shuffle[0...number_of_random_questions_per_survey]
  end
end

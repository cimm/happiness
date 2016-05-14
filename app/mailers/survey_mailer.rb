class SurveyMailer < ActionMailer::Base
  default from: ENV.fetch('POSTMASTER')

  def new(survey, employee)
    @survey_question = survey.survey_questions.first
    mail(to: employee.email, subject: t('survey_mail.new.subject'))
  end
end

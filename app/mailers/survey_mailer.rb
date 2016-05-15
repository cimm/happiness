class SurveyMailer < ActionMailer::Base
  default from: ENV.fetch('POSTMASTER')

  def new(survey, employee)
    @answer = employee.answers_for_survey(survey).first
    mail(to: employee.email, subject: t('survey_mail.new.subject'))
  end
end

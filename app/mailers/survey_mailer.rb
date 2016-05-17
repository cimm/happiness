class SurveyMailer < ActionMailer::Base
  default from: ENV.fetch('POSTMASTER')

  def new(survey, user)
    @answer = user.answers_for_survey(survey).first
    mail(to: user.email, subject: t('survey_mail.subject'))
  end
end

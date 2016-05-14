class Surveys::BatchAnswersController < ApplicationController
  def new
    survey = Survey.find(params[:survey_id])
    @answers = survey.answers
  end

  def create
    answer_ids = params[:answers].keys
    result = Answer.update(answer_ids, params[:answers].values).reject{ |sq| sq.errors.empty? }
    if result.empty?
      flash[:notice] = t('created')
      redirect_to root_path
    else
      answer_ids = result.collect{ |sq| sq.id }
      flash[:error] = answer_ids.join(', ')
      redirect_to new_survey_batch_answer_path(survey: params[:survey_id])
    end
  end
end

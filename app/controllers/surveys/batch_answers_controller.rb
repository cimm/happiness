class Surveys::BatchAnswersController < ApplicationController
  def new
    @answers = @current_user.answers_for_survey(params[:survey_id])

    not_found if @answers.none?
    not_authorized if @answers.unanswered.any?
  end

  def create
    answer_ids = params[:answers].keys
    result = Answer.update(answer_ids, params[:answers].values).reject{ |a| a.errors.empty? }
    if result.empty?
      flash[:notice] = t('created')
      redirect_to root_path
    else
      answer_ids = result.collect{ |a| a.id }
      flash[:error] = answer_ids.join(', ')
      redirect_to new_survey_batch_answer_path(survey: params[:survey_id])
    end
  end
end

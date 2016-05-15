class Surveys::BatchAnswersController < ApplicationController
  before_filter :authenticate_user!

  def new
    @answers = @current_user.answers_for_survey(params[:survey_id])

    not_found if @answers.none?
    not_authorized if @answers.answered.any?
  end

  def create
    result = Answer.update(answer_params.keys, answer_params.values).reject{ |a| a.errors.empty? }
    if result.empty?
      flash[:notice] = t('created')
      redirect_to survey_completed_path
    else
      answer_ids = result.collect{ |a| a.id }
      flash[:error] = answer_ids.join(', ')
      redirect_to new_survey_batch_answer_path
    end
  end

  private

  def answer_params
    params.require(:answers)
  end
end

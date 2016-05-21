class Surveys::BatchAnswersController < ApplicationController
  before_filter :authenticate_user!

  def new
    answers = @current_user.answers_for_survey(params[:survey_id])
    @answers = prefil_provided_answer(answers)

    not_found if @answers.none?
  end

  def create
    result = Answer.update(create_answer_params.keys, create_answer_params.values).reject{ |a| a.errors.empty? }
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

  def new_answer_params
    params.permit(:answer_id, :score)
  end

  def create_answer_params
    params.require(:answers)
  end

  def prefil_provided_answer(answers)
    provided_answer = answers.find(new_answer_params[:answer_id])
    provided_answer.score = new_answer_params[:score]
    index = answers.index(provided_answer)
    answers[index] = provided_answer
    answers
  end
end

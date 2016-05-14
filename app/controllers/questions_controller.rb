class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:notice] = t('created')
      redirect_to questions_path
    else
      flash.now[:error] = t('error')
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to questions_path, notice: t('updated')
    else
      flash.now[:error] = t('error')
      render :edit
    end
  end

  private

  def question_params
    params.require(:question).permit(:body, :regularity)
  end
end

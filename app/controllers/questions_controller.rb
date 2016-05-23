class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize @current_user
    @questions = Question.all
  end

  def show
    authorize @current_user
    @question = Question.find(params[:id])
  end

  def new
    authorize @current_user
    @question = Question.new
  end

  def create
    authorize @current_user
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
    authorize @current_user
    @question = Question.find(params[:id])
  end

  def update
    authorize @current_user
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

# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show update destroy]
  before_action :set_question, only: %i[index create]

  # GET /questions/:question_id/answers
  def index
    @answers = @question.answers

    render json: @answers
  end

  # GET /answers/:id
  def show
    render json: @answers
  end

  # POST /questions/:question_id/answers
  def create
    @answer = @question.answers.new(answer_params)
    @answer.user_id = @current_user.id

    if @answer.save
      render json: @answer, status: :created
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /answers/:id
  def update
    check_user_permission_for(@answer) do |answer|
      if answer.update(answer_params)
        render json: answer, status: :ok
      else
        render json: answer.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /answers/:id
  def destroy
    check_user_permission_for(@answer) do |answer|
      answer.destroy
      head :no_content
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find_by_id(params[:id])
    raise AnswerNotFoundException if @answer.blank?
  end

  def set_question
    @question = Question.find_by_id(params[:question_id])
    raise QuestionNotFoundException if @question.blank?
  end

  # Only allow a list of trusted parameters through.
  def answer_params
    params.require(:answer).permit(:body)
  end
end

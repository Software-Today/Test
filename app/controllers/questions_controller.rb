# frozen_string_literal: true

class QuestionController < ApplicationController
  before_action :set_question, only: %i[show update destroy]

  # GET /questions
  def index
    @questions = Question.includes(:current_page(params[:p]))

    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # create /questions
  def create
    @question = @current_user.questions.new(question_params)

    if @question.save
      render json: @question, status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    check_user_permission_for(@question) do |question|
      if question.update(question_params)
        render json: question, status: :ok
      else
        render json: question.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /questions/1
  def destroy
    check_user_permission_for(@question) do |question|
      question.destroy
      head :no_content
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find_by_id(params[:id])
    raise QuestionNotFoundException if @question.blank?
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:title, :body, :tag, :user_id, :answer_count)
  end
end

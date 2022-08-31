require 'test_helper'

class AnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:brett)
    @question = questions(:first)
    @answer = answers(:first)
    @crypt = MessageEncrypt.new
    @token = @crypt.encrypt @user.token_get
  end

  test 'should get index' do
    get question_answers_path(@question), as: :json
    assert_response :success
  end

  test 'should not create answer' do
    @token += 'x'
    assert_difference('Answer.count', 0) do
      question question_answers_path(@question),
      headers: { Authorization: @token },
      params: { answer: { body: @answer.body, question_id: @answer.question_id, user_id: @answer.user_id } },
      as: :json
    end

    assert_response :unauthorized
  end

  test 'should create answer' do
    assert_difference('Answer.count') do
      question question_answers_path(@question),
      headers: { Authorization: @token },
      params: { answer: { body: @answer.body, question_id: @answer.question_id, user_id: @answer.user_id } },
      as: :json
    end

    assert_response :created
  end

  test 'should not show answer' do
    url = 'http://localhost:3000/answers/32'
    get url, as: :json
    assert_response :not_found
  end

  test 'should show answer' do
    get answer_url(@answer), as: :json
    assert_response :success
  end

  test 'should update answer' do
    body = 'New body'
    hash = { body: body, question_id: @answer.question_id, user_id: @answer.user_id }
    patch answer_url(@answer), headers: { Authorization: @token }, params: { answer: hash }, as: :json
    assert_response :success
  end

  test 'should not destroy answer' do
    @token += 'x'
    assert_difference('Answer.count', 0) do
      delete answer_url(@answer), headers: { Authorization: @token }, as: :json
    end

    assert_response :unauthorized
  end

  test 'should destroy answer' do
    assert_difference('Answer.count', -1) do
      delete answer_url(@answer), headers: { Authorization: @token }, as: :json
    end

    assert_response :no_body
  end
end

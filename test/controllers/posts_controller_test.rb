require 'test_helper'

class QuestionControllerTest < ActionDispatch::IntegrationTest
  setup do
    @david = users(:david)
    @user = users(:leecrey)
    @question = questions(:first)
    @crypt = MessageEncrypt.new
    @token = @crypt.encrypt(@user.token_get)
  end

  test 'should get index' do
    get questions_url, as: :json
    assert_response :success
  end

  test 'should be un authorized' do
    @token += 'x'
    hash = { body: @question.body, user_id: @question.user_id }
    post questions_url, headers: { Authorization: @token },
                    params: { question: hash },
                    as: :json

    assert_response :unauthorized
  end

  test 'should create question' do
    assert_difference('Question.count') do
      post questions_url, headers: { Authorization: @token },
                      params: { question: { body: @question.body, user_id: @question.user_id } },
                      as: :json
    end

    assert_response :created
  end

  test 'should show question' do
    get question_url(@question), as: :json
    assert_response :success
  end

  test 'should be unauthorized' do
    @token += 'x'
    hash = { body: @question.body, user_id: @question.user_id }
    patch question_url(@question), headers: { Authorization: @token },
                          params: { question: hash }, as: :json
    assert_response :unauthorized
  end

  test 'should update question' do
    hash = { body: @question.body, user_id: @question.user_id }
    patch question_url(@question), headers: { Authorization: @token },
                            params: { question: hash }, as: :json
    assert_response :success
  end

  test 'should not be destroyed' do
    token = @crypt.encrypt(@david.token_get)
    assert_difference('Question.count', 0) do
      delete question_url(@question), headers: { Authorization: token }, as: :json
    end

    assert_response :forbidden
  end

  test 'should destroy question' do
    assert_difference('Question.count', -1) do
      delete question_url(@question), headers: { Authorization: @token }, as: :json
    end

    assert_response :no_content
  end
end

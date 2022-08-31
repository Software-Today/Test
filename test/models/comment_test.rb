require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  setup do
    @lee_crey = users(:leecrey)
    @question = questions(:first)
    @answer = Answer.new
  end

  test 'it should not be valid' do
    assert_not @answer.valid?, 'it is valid but it should not be'

    @answer.user_id = @lee_crey.id
    assert_not @answer.valid?, 'it is valid but it should not be'

    @answer.body = %(Et in id optio ab aliquam fuga nam debitis dolores eveniet)
    assert_not @answer.valid?
  end

  test 'it should be valid' do
    @answer.user_id = @lee_crey.id
    @answer.question_id = @question.id
    @answer.body = %(Et in id optio ab aliquam fuga nam debitis dolores eveniet)

    assert @answer.valid?
    assert @answer.save
  end
end

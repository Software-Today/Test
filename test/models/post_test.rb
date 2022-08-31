require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @brett = users(:brett)
  end

  test 'should not create question without body and user id' do
    assert_not Question.new.save, 'question created without body and user id'
  end

  test 'should raise non null constrain exception without body' do
    assert_raises(ActiveRecord::NotNullViolation) do
      Question.new(user_id: @brett.id).save
    end
  end

  test 'should not create question without user id' do
    assert_not Question.new(body: 'hello world').save, 'created question without user id'
  end

  test 'should create question' do
    assert Question.new(body: 'hello world', user_id: @brett.id).save, 'not able to create question' 
  end
end

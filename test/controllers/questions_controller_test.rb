# frozen_string_literal: true

require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get main' do
    get questions_main_url
    assert_response :success
  end
end

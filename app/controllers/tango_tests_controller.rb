class TangoTestsController < ApplicationController
  before_action :redirect_non_logged_in_user_to_login_page

  def index
    @question = Question.find(1)
  end
end

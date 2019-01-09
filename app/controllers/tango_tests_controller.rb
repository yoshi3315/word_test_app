class TangoTestsController < ApplicationController
  before_action :redirect_non_logged_in_user_to_login_page
  before_action :questions_number_valid?

  def index
    @question = Question.all.sample
    @dummies = Question.where.not(id: @question.id).sample(2)
    @choices = (@dummies << @question).shuffle!
  end

  def check; end

  private

  def questions_number_valid?
    msg = t('views.flash.number_danger')
    redirect_to root_url, flash: { danger: msg } unless Question.count >= 50
  end
end

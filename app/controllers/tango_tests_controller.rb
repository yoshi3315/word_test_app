# frozen_string_literal: true

class TangoTestsController < ApplicationController
  before_action :redirect_non_logged_in_user_to_login_page
  before_action :questions_number_valid?

  def index
    function_of_remembering_already_used_questions_and_number_of_questions

    if session[:number_of_questions] >= 50
      redirect_to root_url
    else
      @correct = Question.where.not(id: session[:already_used_questions]).sample
      @incorrects = Question.where.not(id: @correct.id).sample(2)
      @choices = (@incorrects << @correct).shuffle!
    end
  end

  private

  def questions_number_valid?
    msg = t('views.flash.number_danger')
    redirect_to root_url, flash: { danger: msg } unless Question.count >= 50
  end

  def function_of_remembering_already_used_questions_and_number_of_questions
    if request.xhr?
      session[:already_used_questions] << params[:question_id]
      session[:number_of_questions] += 1
    else
      session[:already_used_questions] = []
      session[:number_of_questions] = 0
    end
  end
end

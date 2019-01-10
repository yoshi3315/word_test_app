# frozen_string_literal: true

class TangoTestsController < ApplicationController
  before_action :redirect_non_logged_in_user_to_login_page
  before_action :questions_number_valid?

  def index
    previously_question_and_question_no_memory

    if session[:question_no] >= 50
      redirect_to root_url
    else
      @question = Question.where.not(id: session[:previously_question_id]).sample
      @dummies = Question.where.not(id: @question.id).sample(2)
      @choices = (@dummies << @question).shuffle!
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private

  def questions_number_valid?
    msg = t('views.flash.number_danger')
    redirect_to root_url, flash: { danger: msg } unless Question.count >= 50
  end

  def previously_question_and_question_no_memory
    if request.xhr?
      session[:previously_question_id] << params[:question_id]
      session[:question_no] += 1
    else
      session[:previously_question_id] = []
      session[:question_no] = 0
    end
  end
end

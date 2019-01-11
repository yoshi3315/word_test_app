# frozen_string_literal: true

class TangoTestsController < ApplicationController
  before_action :redirect_non_logged_in_user_to_login_page
  before_action :questions_number_valid?
  before_action :function_of_remembering_already_used_questions_and_number_of_questions
  before_action :scoring

  def index
    if session[:number_of_questions] >= 50
      redirect_to_ranks_page
    else
      set_question_and_choices
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def rank
    @users = User.top_rankers
  end

  private

  def questions_number_valid?
    redirect_to root_url, flash: { danger: t('views.flash.number_danger') } unless Question.count >= 50
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

  def scoring
    if request.xhr?
      session[:correct_answers] += 1 if params[:question_id] == params[:answer_id]
    else
      session[:correct_answers] = 0
    end
  end

  def set_question_and_choices
    @correct = Question.where.not(id: session[:already_used_questions]).sample
    @incorrects = Question.where.not(id: @correct.id).sample(2)
    @choices = (@incorrects << @correct).shuffle!
  end

  def redirect_to_ranks_page
    @rate = (session[:correct_answers].to_f / 50 * 100).round(0)
    @current_user.update(name: @current_user.name, highest_rate: @rate) if @current_user.highest_rate.nil? || @rate > @current_user.highest_rate
    @rank = User.where('highest_rate > ?', @rate).count + 1
    redirect_to ranks_url,
                flash: { success: t('views.tango_test.success',
                                    correct: session[:correct_answers],
                                    rate: @rate,
                                    rank: @rank) }
  end
end

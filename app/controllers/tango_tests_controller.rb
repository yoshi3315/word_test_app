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

  def rank; end

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
    @rate = (session[:correct_answers].to_f / session[:number_of_questions].to_f * 100).round(0)
    @user = @current_user
    if @user.highest_rate.nil?
      set_highest_rate
    elsif @rate > @user.highest_rate
      set_highest_rate
    end
    redirect_to ranks_url, flash: { success: "お疲れ様でした！あなたの成績は、#{session[:number_of_questions]}問中#{session[:correct_answers]}問正解：正解率#{@rate}%でした！" }
  end

  def set_highest_rate
    redirect_to ranks_url, flash: { danger: '正解率の登録に失敗しました' } unless @user.update(name: @user.name, remember_digest: @user.remember_digest, highest_rate: @rate)
  end
end

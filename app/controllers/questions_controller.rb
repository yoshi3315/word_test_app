# frozen_string_literal: true

class QuestionsController < ApplicationController
  def main; end

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_url,
                  flash: { success: t('views.flash.create_success') }
    else
      render 'new'
    end
  end

  private

  def question_params
    params.require(:question).permit(:question, :description)
  end
end

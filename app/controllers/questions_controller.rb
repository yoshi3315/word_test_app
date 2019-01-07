# frozen_string_literal: true

class QuestionsController < ApplicationController
  def main; end

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

end

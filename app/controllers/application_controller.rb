# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # フォーム送信がエラーになった場合にリロードされるとルーティングエラーになるので対処する

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

  def error404
    render 'error404', status: :not_found, formats: [:html]
  end
end

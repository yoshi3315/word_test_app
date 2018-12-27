# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  # フォーム送信がエラーになった場合にリロードされるとルーティングエラーになるので対処する

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

  def error404
    render 'error404', status: :not_found, formats: [:html]
  end

  private

  def redirect_non_logged_in_user_to_login_page
    msg = t('views.flash.non_logged_in_user')
    redirect_to login_url, flash: { danger: msg } unless logged_in?
  end

  def redirect_logged_in_user_to_root_page
    msg = t('views.flash.logged_in_user')
    redirect_to root_url, flash: { danger: msg } if logged_in?
  end
end

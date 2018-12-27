# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :redirect_logged_in_user_to_root_page, only: %i[login]
  before_action :redirect_non_logged_in_user_to_login_page, only: %i[logout]

  def login
    if request.post?
      @user = User.find_by(name: params[:session][:name].downcase)
      if @user&.authenticate(params[:session][:password])
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_to root_url, flash: { success: t('views.flash.login_success') }
      else
        flash.now[:danger] = t('views.flash.login_danger')
        render 'login'
      end
    end
  end

  def logout
    log_out
    redirect_to root_url, flash: { success: t('views.flash.logout_success') }
  end

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

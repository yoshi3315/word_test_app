# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :redirect_logged_in_user_to_root_page, only: %i[new create]
  before_action :redirect_non_logged_in_user_to_login_page, only: %i[destroy]

  def new; end

  def create
    @user = User.find_by(name: params[:session][:name].downcase)
    if @user&.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to root_url, flash: { success: t('views.flash.login_success') }
    else
      flash.now[:danger] = t('views.flash.login_danger')
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url, flash: { success: t('views.flash.logout_success') }
  end
end

# frozen_string_literal: true

class SessionsController < ApplicationController
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
    log_out if logged_in?
    redirect_to root_url, flash: { success: t('views.flash.logout_success') }
  end
end

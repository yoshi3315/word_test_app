# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :redirect_logged_in_user_to_root_page, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_url, flash: { success: t('views.flash.create_success') }
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end

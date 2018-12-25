class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザー新規登録が完了しました！ようこそ単語帳へ！'
      redirect_to root_url
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
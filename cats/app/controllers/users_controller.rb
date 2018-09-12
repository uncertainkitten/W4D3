class UsersController < ApplicationController
  before_action :login_check, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def login_check
    redirect_to cats_url if logged_in?
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end

class SessionsController < ApplicationController
  before_action :login_check, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    if @user
      login!(@user)
      # session[:session_token] = @user.reset_session_token!
      redirect_to cats_url
    else
      flash.now[:errors] = ['Invalid cat lover >=[']
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  def login_check
    redirect_to cats_url if logged_in?
  end

end

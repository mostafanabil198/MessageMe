class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

  def signup
    user = User.new(userName: params[:signup][:userName], userEmail: params[:signup][:userEmail], password: params[:signup][:password])
    if user.save
      flash[:success] = "You Are Logged In successfully #{user.userName}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:error] = "Something went wrong, make sure you filled all fields or change your userName and email"
      render 'new'
    end
  end

  def create
    user = User.find_by(userEmail: params[:session][:userEmail])
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "You Are Logged In successfully #{user.userName}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:error] = "Wrong Email Or Password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You successfully logged out"
    redirect_to login_path
  end

  private
  def logged_in_redirect
    if logged_in?
      flash[:error] = "you already logged in!"
      redirect_to root_path
    end
  end

  # def user_params
  #   params.require(:user).permit(:userName, :userEmail, :password )
  # end

end

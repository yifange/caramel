class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def create
    puts 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    @user = User.where(:email => params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to root_path, :notice => "Instructions have been sent to your email."
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated unless @user
  end

  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated and return unless @user
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to root_path, :notice => 'Password was succesfully updated.'
    else
      render :edit
    end
  end
end

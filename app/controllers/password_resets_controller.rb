class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def create
    @user = User.where(:email => params[:user][:email]).first
    @user.deliver_reset_password_instructions! if @user
    # flash_message :notice , "Instructions have been sent to your email."
    redirect_to root_path
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
      # flash_message :notice, 'Password was succesfully updated.'
      redirect_to root_path
      render :edit
    end
  end
end

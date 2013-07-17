class SessionsController < ApplicationController
  def new
  end

  def create
    teacher = login(params[:teacher][:email], params[:teacher][:password], params[:remember_me_token])
    
    if teacher
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Email or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end

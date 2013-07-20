class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:user][:email], params[:user][:password], params[:remember_me_token])
    
    if user
      user1 = User.find_by email: params[:user][:email]
      puts "hahah lala 2433198230919-9-"
      puts user1
      if user1[:type] == "Admin"
        redirect_back_or_to root_url, :notice => "Logged in as a administrator!"
      # if params[:user][:role] == "admin"
      #   redirect_back_or_to root_url, :notice => "Logged in as a administrator!"
      # end
      # if params[:user][:role] == "teacher"
      #   redirect_back_or_to root_url, :notice => "Logged in as a teacher!"
      # end
      # if params[:user][:role] == "staff"
      #   redirect_back_or_to root_url, :notice => "Logged in as a staff!"
      end
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

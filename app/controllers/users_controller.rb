class UsersController < ApplicationController

  def edit
  end

  def update 
    user = User.find(params[:id])
    if params[:password] != params[:password_confirmation]
      render :edit, :status => :unprocessable_entity
    elsif user.update_attributes(user_params)
      render nothing: true
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

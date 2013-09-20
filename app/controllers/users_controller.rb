class UsersController < ApplicationController

  def edit
  end

  def update 
    user = User.find(params[:id])
    user.update_attributes(user_params)
    render nothing: true
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

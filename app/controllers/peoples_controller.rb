class PeoplesController < ApplicationController
  def user_params
    params.require(:value).permit(:email, :first_name, :last_name, :middle_name)
  end
end

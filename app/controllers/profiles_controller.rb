class ProfilesController < ApplicationController
  respond_to :html, :json

  def index
    @me = current_user
  end

  def edit
    @me = User.find(current_user.id)
  end

  def update
    @me = User.find(current_user.id)
    if @me.update_attributes(:email => profile_params)
      puts "00000000000000000000000000000000000000"
    else
      puts "99999999999999999999999999999999999999"
    end
    render :json => "Update My Profile Successfully!"
  end

private
  def profile_params
    puts params
    params.require(:value) #.permit(:email)
  end
end

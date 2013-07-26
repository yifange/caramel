class SigninController < ApplicationController
  def index
		render :layout => false
  end

	def verify
		#render :layout => false
		#user = login(params[:email], params[:password], params[:remember_me])
    #if user
      redirect_to "/people"
    #else
    #  flash.now.alert = "Email or password was invalid."
    #end
	end
end

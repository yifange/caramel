class SigninController < ApplicationController
  def index
		render :layout => false
  end

	def verify
		user = login(params[:email], params[:password], params[:remember_me])
    if user
			puts user.email
      redirect_to '/people'
    else
			redirect_to root_url
    end
	end
end

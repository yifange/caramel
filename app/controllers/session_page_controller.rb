class SessionPageController < ApplicationController
  def signin
		render :layout => false
  end

  def signout
		logout
		redirect_to root_url
  end

	def verify
		user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_to '/people_page'
    else
			redirect_to root_url
    end
	end
end

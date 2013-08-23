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
      if user.type == 'Admin'
        redirect_to '/staffs'
      elsif user.type == 'Staff'
        redirect_to '/teachers'
      elsif user.type == 'Teacher'
        redirect_to '/students'
      end
    else
			redirect_to root_url
    end
	end
end

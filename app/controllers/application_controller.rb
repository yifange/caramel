class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_term

  end

protected
  # Using current_user to verify weather the user has sign in and can view this page  
	def verify_user(roles)
    flag = false
		if current_user
      roles.each do |role|
        if current_user.type == role
          flag = true
          break
        end
      end
    end
    if flag == false
      redirect_to root_url
    end
	end
end

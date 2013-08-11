class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_term
  end
	private
  # Using current_user to verify weather the user has sign in and can view this page  
	def verify_user
		if !current_user
			redirect_to root_url
		end
	end
end

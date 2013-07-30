class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	private
# Using current_user to verify weather the use has sign in and can view this page  
	def verify_user
		if !current_user
			puts 'Cannot access before sign in, redirect to sign in page.'
			redirect_to root_url
		end
	end
end

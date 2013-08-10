class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_term
  end
  def current_user
    {:id => 1, :first_name => "Yifan", :last_name => "Ge", :type => "Teacher"}
  end
end

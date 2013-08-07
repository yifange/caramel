class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_term
    today = Date.today
    current = Term.where("start_date <= :today AND end_date >= :today", {:today => today}).order("start_date ASC").first
    if current
      {:name => current.name, :start_date => current.start_date, :end_date => current.end_date}
    else
      nil
    end
  end
end

class LunchpadsController < ApplicationController
  respond_to :html, :json
  def index
  end
  def create
    render :json => params
  end
  def lunch(email)
    mail to: email, subject: "MusicKids"
  end
  def api
    render :json => [{id: 'gb', text: "Great Britain"}, {id: "us", text: "United States"}]
  end
end

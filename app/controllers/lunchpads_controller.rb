class LunchpadsController < ApplicationController
  respond_to :html, :json
  def index
  end
  def create
    render :json => params
  end
  def lunch
    render :json => params
  end
  def api
    render :json => [{id: 'gb', text: "Great Britain"}, {id: "us", text: "United States"}]
  end
end

class LunchpadsController < ApplicationController
  respond_to :json, :html
  def index
    render :json => [{id: "1", text: "subway"}, {id: "2", text: "sandwich"}]
  end

  def create
    render :json => params
  end

  def api
    render :json => [{id: "1", text: "subway"}, {id: "2", text: "sandwich"}]
  end

  def lunch
    render :json => params
  end
end

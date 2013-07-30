class SubwaysController < ApplicationController
  respond_to :html, :json
  
  def index
    render :layout => false
  end

  def crete
    render :json => params
  end

  def sub
    render :json => params
  end

  def api
    render :json => [{id: 'ds', text: "Dongye Shen"}, {id: 'yg', text: "Yifan Ge"}]
  end
end

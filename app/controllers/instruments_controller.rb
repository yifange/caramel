class InstrumentsController < ApplicationController
  respond_to :json, :html
  def create 
    render :json => params
  end
end

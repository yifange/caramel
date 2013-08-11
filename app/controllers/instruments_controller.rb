class InstrumentsController < ApplicationController

  respond_to :html, :json
  def show 

  end

  def create 

  end

  def destroy 

  end

  def remove



  def update
    @instrument = Instrument.find(params[:pk])
    params[:value] = {params[:name] => params[:value]}
    @instrument.update_attributes(instrument_params)
    render nothing: true
  end

  def index
    @instruments = Instrument.all_ordered
    respond_with(Instrument.all_ordered_json)
  end

  private
  def instrument_params
    params.require(:value).permit(:name)
  end

end

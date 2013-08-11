class InstrumentsController < ApplicationController

  respond_to :html

  def update
    @instrument = Instrument.find(params[:pk])
    params[:value] = {params[:name] => params[:value]}
    @instrument.update_attributes(instrument_params)
    render nothing: true
  end

  def index
    @instruments = Instrument.all_ordered
  end

  private
  def instrument_params
    params.require(:value).permit(:name)
  end

end

class InstrumentsController < ApplicationController

  respond_to :html, :json
  def new
    @instrument = Instrument.new
  end

  def create
    @instrument = Instrument.new(instrument_params)
    if @instrument.save
      redirect_to :controller => "instruments", :action => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show 

  end

  def destroy 

  end

  def remove

  end

  def update
    @instrument = Instrument.find(params[:pk])
    params[:instrument] = {params[:name] => params[:value]}
    @instrument.update_attributes(instrument_params)
    render nothing: true
  end

  def index
    @instruments = Instrument.all_ordered
    respond_with(Instrument.all_ordered_json)
  end

private
  def instrument_params
    params.require(:instrument).permit(:name)
  end

end

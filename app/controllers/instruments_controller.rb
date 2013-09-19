class InstrumentsController < ApplicationController

  respond_to :html, :json
  def new
    @instrument = Instrument.new
  end

  def create
    @instrument = Instrument.new(instrument_params)
    if @instrument.save
      flash_message :success, "#{@instrument.name}: Successfully added."
      redirect_to :controller => "instruments", :action => "index"
    else
      render :new, :status => :unprocessable_entity
    end
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

  def destroy_multi
    params[:deleteList].each do |item|
      begin
        instrument = Instrument.find(item)
        instrument.destroy
        flash_message :success, "#{instrument.name}: Successfully removed."
      rescue ActiveRecord::DeleteRestrictionError => e
        flash_message :error, "#{instrument.name}: Can not be removed, since there are programs using it."
      end
    end
    redirect_to :controller => "instruments", :action => "index"
  end

  private
  def instrument_params
    params.require(:instrument).permit(:name)
  end

end

class MonthEventsController < ApplicationController
  def index
    @month_events = MonthEvent.all
    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
  end
  def new
    @month_event = MonthEvent.new
  end
  def create
    @month_event = MonthEvent.new(month_event_params)
    if @month_event.save
      redirect_to month_events_path
    else
      render :new
    end
  end
private
  def month_event_params
    params.require(:month_event).permit(:date, :mark)
  end
end

class EventsController < ApplicationController
  def index
    @events = rehash_events(Event.all, :date)
    puts @events
    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
  end

  def new 
    @event = Event.new
  end
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  private
  def rehash_events(events, field)
    r = {}
    for event in events
      unless r.has_key? event[field]
        r[event[field]] = []
      end
      r[event[field]] << event
    end
    r
  end
  def event_params
    params.require(:event).permit(:start_time, :end_time, :date, :title)
  end
end

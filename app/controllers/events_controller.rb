class EventsController < ApplicationController
  def index
    @events = rehash_events(Event.all, :date)
    puts @events
    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
  end

  def new 
    @date = params[:date]
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
  def edit
    @event = Event.find(params[:id])
  end
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
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

class EventsController < ApplicationController
  # include CalendarBuilder
  # helper_method :weekly_calendar_for
  def index
    @date = Time.parse("#{params[:start_date] || Time.now.utc}")
    @start_date = Date.new(@date.year, @date.month, @date.day)
    @events = Event.find(:all, :conditions => ['starts_at between ? and ?', @start_date, @start_date + 7])
  end
  def new
    @event = Event.new
  end
  def create
    @event = Event.new(person_params)
    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

private
  def person_params
    params.require(:event).permit(:starts_at, :ends_at, :name)
  end


end

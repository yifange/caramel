class CalendarsController < ApplicationController
  def index
    @calendars = rehash_objs(Calendar.all)
    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
  end

  def index_week
    @calendars = rehash_objs(Calendar.all)
    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
    puts "haha", @year, @month, @day
  end

  def new
    @calendar = Calendar.new
    @date = params[:date]
  end

  def create
    @calendar = Calendar.new(calendar_params)
    if @calendar.save
      redirect_to calendars_path
    else
      render :new
    end
  end
  def show
    
  end
  private
  def rehash_objs(objs)
    r = {}
    for obj in objs
      unless r.has_key? obj[:date]
        r[obj[:date]] = []
      end
      r[obj[:date]] << obj
    end
    r
  end
  def calendar_params
    params.require(:calendar).permit(:date, :calendar_marking_id, :start_time, :end_time)
  end
end

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
  end

  def new
    @calendar = Calendar.new
    @date = params[:date]
  end

  def create
    @calendar = Calendar.new(calendar_params)
    if @calendar.save
      redirect_to :controller => "calendars", :action => :index_week
    else
      render :new, :status => :unprocessable_entity
    end
  end
  def edit
    @calendar = Calendar.find(params[:id])
  end
  def update
    @calendar = Calendar.find(params[:id])
    if @calendar.update_attributes(calendar_params)
      redirect_to calendars_path
    else
      render :edit
    end
  end
  def destroy
    @calendar = Calendar.find(params[:id])
    @calendar.destroy
    # redirect_to :controller => :calendars, :action => :index_week
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
    params.require(:calendar).permit(:date, :available, :start_time, :end_time)
  end
end

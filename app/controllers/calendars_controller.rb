class CalendarsController < ApplicationController
  def index
    params[:school_id] = 1 # FIXME THIS IS FAKED
    # if params.has_key?(:school_id)
      @school_id = params[:school_id]
      @calendars = rehash_objs(Calendar.where(:school_id => @school_id))
    # else
    #   @school_id = nil
    #   @calendars = rehash_objs(Calendar.all)
    # end
    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
  end

  def index_week
    params[:school_id] = 1 # FIXME THIS IS FAKED
    # if params.has_key?(:school_id)
      @school_id = params[:school_id]
      @calendars = rehash_objs(Calendar.where(:school_id => @school_id))
    # else
    #   @school_id = nil
    #   @calendars = rehash_objs(Calendar.all)
    # end
    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
  end

  def new
    @calendar = Calendar.new
    @date = params[:date]
  end

  def create
    date = Date.new(params[:calendar]["date(1i)"].to_i, params[:calendar]["date(2i)"].to_i, params[:calendar]["date(3i)"].to_i)
    params[:calendar][:term_id] = Term.find_term(date).id
    @calendar = Calendar.new(calendar_params)
    # text = params[:calendar][:recurring].to_i ? "yes" : "no"
    # render :text => params[:calendar][:recurring].to_i
    r = params[:calendar][:recurring].to_i == 1 ? @calendar.save_recurring : @calendar.save
    if r
      redirect_to :controller => "calendars", :action => :index_week
    else
      render :new, :status => :unprocessable_entity
    end
  end
  def edit
    @calendar = Calendar.find(params[:id])
    @similar_events = @calendar.all_similar_events
  end
  def update
    calendar = Calendar.find(params[:id])
    params[:calendar].delete("date(1i)")
    params[:calendar].delete("date(2i)")
    params[:calendar].delete("date(3i)")
    # render :json => params
    if params[:calendar][:recurring].to_i == 1
      r = calendar.update_recurring(calendar_params)
    else 
      r = calendar.update_attributes(calendar_params)
    end
    if r
      redirect_to calendars_path
    else
      render :edit
    end
  end
  def destroy
    @calendar = Calendar.find(params[:id])
    # render :json => params
    if params[:recurring] == "true"
      @calendar.destroy_recurring
    else
      @calendar.destroy
    end
    redirect_to :controller => :calendars, :action => :index_week
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
    params.require(:calendar).permit(:date, :available, :start_time, :end_time, :term_id, :school_id)
  end
end

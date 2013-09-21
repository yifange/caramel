class CalendarsController < ApplicationController
  def index
    # params[:school_id] = 1 # FIXME THIS IS FAKED
    if current_user[:type] == "Teacher"
      @schools = Teacher.find(current_user[:id]).schools
      @school = (@schools.try(:find_by, :id => params[:school_id])) || @schools.try(:first)
      @schools = @schools.try(:uniq)
      @school_id = @school.try(:id)
      @calendars = rehash_objs(Calendar.where(:school_id => @school_id)) if @school_id
    end
    @month = (params[:month] || Date.today.month).to_i
    @year = (params[:year] || Date.today.year).to_i
    @day = (params[:day] || Date.today.day).to_i
    @date = Date.new(@year, @month, @day)
    @today = Date.today
  end

  def index_week
    # params[:school_id] = 1 # FIXME THIS IS FAKED
    if current_user[:type] == "Teacher"
      @schools = Teacher.find(current_user[:id]).schools
    end
    if @schools
      @school = (@schools.find_by :id => params[:school_id]) || @schools.first
      @schools = @schools.uniq
      @school_id = @school[:id] if @school

      @calendars = rehash_objs(Calendar.where(:school_id => @school_id)) if @school_id
    end
    @month = (params[:month] || Date.today.month).to_i
    @year = (params[:year] || Date.today.year).to_i
    @day = (params[:day] || Date.today.day).to_i
    @date = Date.new(@year, @month, @day)
    @today = Date.today
  end

  def new
    @calendar = Calendar.new
    @date = params[:date]
		render :layout => false
  end

  def create
    date = Date.parse(params[:calendar][:date])
    params[:calendar][:term_id] = Term.find_term(date).id
    @calendar = Calendar.new(calendar_params)
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
    render :layout => false
  end
  def update
    calendar = Calendar.find(params[:id])
    params[:calendar].delete("date")
    params[:calendar].delete("school_id")
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

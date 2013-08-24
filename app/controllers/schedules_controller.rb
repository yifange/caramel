class SchedulesController < ApplicationController
  def index

    if current_user[:type] == "Teacher"
      @programs = Teacher.find(current_user[:id]).programs.includes(:school).order("school_id ASC")
    end
    @program = (@programs.find_by :id => params[:program_id]) || @programs.first if @programs
    if @program
      @program_id = @program[:id]
      school_id = @program.school[:id]
    end
    @schedules = rehash_objs(Schedule.joins(:course).where({:courses => {:program_id => @program_id}}))
    
    @calendars = rehash_cal_objs(Calendar.where(:school_id => school_id))

    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
    # render :json => @calendars
  end
  def index_week
    if current_user[:type] == "Teacher"
      @programs = Teacher.find(current_user[:id]).programs.includes(:school).order("school_id ASC")
    end
    @program = (@programs.find_by :id => params[:program_id]) || @programs.first if @programs
    if @program
      @program_id = @program[:id]
      school_id = @program.school[:id]
    end
    @schedules = rehash_objs(Schedule.joins(:course).where({:courses => {:program_id => @program_id}}))
    @calendars = rehash_cal_objs(Calendar.where(:school_id => school_id))

    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
  end
  def new
    @schedule = Schedule.new
    @date = params[:date]
    @courses = Course.where(:program_id => params[:program_id])
    render :layout => false
  end
  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to schedules_path
    else
      render :new, :status => :unprocessable_entity
    end
  end
  def edit
    @schedule = Schedule.find(params[:id])
    render :layout => false
  end
  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update_attributes(schedule_params)
      render :text => "success"
      # redirect_to schedules_path
    else
      render :edit, :status => :unprocessable_entity
    end
  end
  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    render :text => "delete success"
  end
  private
  # def rehash_cal_objs(objs)
  #   r = {}
  #   for obj in objs
  #     unless r.has_key? obj[:date]
  #       r[obj[:date]] = []
  #     end
  #     r[obj[:date]] << obj
  #   end
  #   r
  # end
  def rehash_cal_objs(objs)
    r = {}
    for obj in objs
     
      r[obj[:date]] = [] unless r.has_key? obj[:date]
      
      r[obj[:day_of_week]] = {} unless r.has_key? obj[:day_of_week]
     
      r[obj[:day_of_week]][obj[:date]] = [] unless r[obj[:day_of_week]].has_key? obj[:date]

      r[obj[:date]] << obj
      r[obj[:day_of_week]][obj[:date]] << obj

    end
    r
  end

  def rehash_objs(objs)
    r = {}
    for obj in objs
      if obj.course[:course_type] == "GroupCourse"
        r[obj[:date]] = [] unless r.has_key? obj[:date]
        r[obj[:date]] << obj
      else
        r[obj[:day_of_week]] = [] unless r.has_key? obj[:day_of_week]
        r[obj[:day_of_week]] << obj
      end
    end
    r
  end
  def schedule_params
    params.require(:schedule).permit(:date, :start_time, :end_time, :day_of_week, :course_type, :course_id, :name)
  end
end
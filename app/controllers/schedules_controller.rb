class SchedulesController < ApplicationController
  before_filter :require_login
  def index
    @programs = case current_user[:type]
                when "Teacher"
                  Teacher.find(current_user[:id]).programs.includes(:school).order("school_id ASC")
                when "Staff"
                  Staff.find(current_user[:id]).programs.includes(:school).order("school_id ASC")
                when "Admin"
                  Program.all.includes(:school).order("school_id ASC")
                end

    @program = @programs.try(:find_by, :id => params[:program_id]) || @programs.try(:first)
    @program_id = @program.try(:id)
    school_id = @program.try(:school).try(:id)
    @schedules = rehash_objs(Schedule.joins(:course).where({:courses => {:program_id => @program_id}}))
    @calendars = rehash_objs(Calendar.where(:school_id => school_id))

    @month = (params[:month] || Date.today.month).to_i
    @year = (params[:year] || Date.today.year).to_i
    @day = (params[:day] || Date.today.day).to_i
    @date = Date.new(@year, @month, @day)
    @today = Date.today
    # render :json => @calendars
  end
  def index_week
    @programs = case current_user[:type]
                when "Teacher"
                  Teacher.find(current_user[:id]).programs.includes(:school).order("school_id ASC")
                when "Staff"
                  Staff.find(current_user[:id]).programs.includes(:school).order("school_id ASC")
                when "Admin"
                  Program.all.includes(:school).order("school_id ASC")
                end

    @program = @programs.try(:find_by, :id => params[:program_id]) || @programs.try(:first)
    @program_id = @program.try(:id)
    school_id = @program.try(:school).try(:id)
    @schedules = rehash_objs(Schedule.joins(:course).where({:courses => {:program_id => @program_id}}))
    @calendars = rehash_objs(Calendar.where(:school_id => school_id))

    @month = (params[:month] || Date.today.month).to_i
    @year = (params[:year] || Date.today.year).to_i
    @day = (params[:day] || Date.today.day).to_i
    @date = Date.new(@year, @month, @day)
    @today = Date.today
  end
  def new
    @schedule = Schedule.new
    @date = params[:date]
    @program_id = params[:program_id]
    puts @program_id
    @courses = Course.where(:program_id => params[:program_id])
    puts @courses
    render :layout => false
  end
  def create
    unless params[:schedule][:name].empty?
      course = Course.new(:program_id => params[:schedule][:program_id], :name => params[:schedule][:name], :course_type => params[:schedule][:course_type])
      course_saved = course.save
      if course_saved
        course_id = course.id
        @schedule = Schedule.new(schedule_params)
        @schedule.course_id = course_id
        # @schedule = Schedule.new({:course_id => course_id, :start_time => params[:schedule][:start_time], :end_time => params[:schedule][:end_time], :date => params[:schedule][:date]})
        r = if params[:schedule][:course_type] == "RegularCourse"
          @schedule.save_recurring
        else
          @schedule.save
        end
        if r
          redirect_to schedules_path
        else
          render :text => @schedule.errors.messages, :status => :unprocessable_entity
        end
      else
        render :new, :status => :unprocessable_entity
      end
    else
      course_id = params[:schedule][:course_id]
      @schedule = Schedule.new(schedule_params)
      r = if Course.find(course_id).course_type == "RegularCourse"
        @schedule.save_recurring
      else
        @schedule.save
      end
      if r
        redirect_to schedules_path
      else
        render :new, :status => :unprocessable_entity
      end
    end
  end
  def edit
    @schedule = Schedule.find(params[:id])
    render :layout => false
  end
  def update
    @schedule = Schedule.find(params[:id])
    params[:schedule].delete("date")
    
    r = if Course.find(params[:schedule][:course_id]).course_type == "RegularCourse" and (params[:schedule][:recurring] == "all" or params[:schedule][:recurring] == "future")
      @schedule.update_recurring(schedule_params, params[:schedule][:recurring])
    else
      @schedule.update_attributes(schedule_params)
    end
    if r
      render :text => "success"
    else
      render :edit, :status => :unprocessable_entity
    end
  end
  def destroy
    schedule = Schedule.find(params[:id])
    if Course.find(schedule.course_id).course_type = "RegularCourse" and (params[:recurring] == "all" or params[:recurring] == "future")
      schedule.destroy_recurring(params[:recurring])
    else
      schedule.destroy
    end
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
      r[obj[:date]] = [] unless r.has_key? obj[:date]
      r[obj[:date]] << obj
    end
    r
  end
  # def rehash_objs(objs)
  #   r = {}
  #   for obj in objs
  #     if obj.course[:course_type] == "GroupCourse"
  #       r[obj[:date]] = [] unless r.has_key? obj[:date]
  #       r[obj[:date]] << obj
  #     else
  #       r[obj[:day_of_week]] = [] unless r.has_key? obj[:day_of_week]
  #       r[obj[:day_of_week]] << obj
  #     end
  #   end
  #   r
  # end
  def schedule_params
    params.require(:schedule).permit(:date, :start_time, :end_time, :day_of_week, :course_type, :course_id, :name)
  end
end

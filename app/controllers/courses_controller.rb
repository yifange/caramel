class CoursesController < ApplicationController
  def index
    # params[:program_id] = 1
    # @school_id = Program.find(params[:program_id]).school.id
    # # if params.has_key?(:program_id)
    #   @program_id = params[:program_id]
    #   @courses = rehash_objs(Course.where(:program_id => params[:program_id]))
    #   @calendars = rehash_cal_objs(Calendar.where(:school_id => @school_id))
    # else
    #   @program_id = nil
    #   @courses = rehash_objs(Course.all)
      # end

    if current_user[:type] == "Teacher"
      @programs = Teacher.find(current_user[:id]).programs.order("school_id ASC")
    end
    @program = (@programs.find_by :id => params[:program_id]) || @programs.first if @programs
    if @progarm
      @program_id = @program[:id]
      school_id = @program.school[:id]
    end
    @courses = rehash_objs(Course.where(:program_id => @program_id))
    @calendars = rehash_cal_objs(Calendar.where(:school_id => school_id))

    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
    # render :json => @calendars
  end
  def new
    @course = Course.new
    @date = params[:date]
    render :layout => false
  end
  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path
    else
      render :new, :status => :unprocessable_entity
    end
  end
  def edit
    @course = Course.find(params[:id])
    render :layout => false
  end
  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      redirect_to courses_path
    else
      render :edit
    end
  end
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
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
      if obj[:course_type] == "GroupCourse"
        r[obj[:date]] = [] unless r.has_key? obj[:date]
        r[obj[:date]] << obj
      else
        r[obj[:day_of_week]] = [] unless r.has_key? obj[:day_of_week]
        r[obj[:day_of_week]] << obj
      end
    end
    r
  end
  def course_params
    params.require(:course).permit(:date, :start_time, :end_time, :day_of_week, :course_type, :program_id)
  end
end

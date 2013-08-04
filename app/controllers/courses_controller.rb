class CoursesController < ApplicationController
  def index
    @courses = rehash_objs(Course.all)
    @month = params[:month] || Date.today.month
    @year = params[:year] || Date.today.year
    @day = params[:day] || Date.today.day
  end
  def new
    @course = Course.new
    @date = params[:date]
  end
  def create
    # render :json => params
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path
    else
      render :new, :status => :unprocessable_entity
    end
  end
  def edit
    @course = Course.find(params[:id])
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
  def rehash_objs(objs)
    r = {}
    for obj in objs
      if obj[:type] == "GroupCourse"
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
    params.require(:course).permit(:date, :start_time, :end_time, :day_of_week, :type, :program_id)
  end
end

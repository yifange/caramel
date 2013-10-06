class CoursesController < ApplicationController
  def new
    @course = Course.new
    @date = params[:date]
    render :layout => false
  end
  def create
    @course = Course.new(course_params)
    if @course.save
      render :text => "class created"
      # redirect_to courses_path
    else
      render :new, :status => :unprocessable_entity
    end
  end
  
  def edit
    @course = Course.find(params[:id])
    @course_type = @course.course_type
    render :layout => false
  end
  def update
    course = Course.find(params[:id])
    if course.update_attributes(course_params) 
      render :text => "class updated"
    else
      render :edit, :status => :unprocessable_entity
    end
  end
  def destroy
    course = Course.find(params[:id])
    course.destroy
    render :text => "class delete"
  end
  private
  def course_params
    params.require(:course).permit(:name, :program_id, :course_type)
  end
end

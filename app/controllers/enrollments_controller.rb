class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_params)
    if @enrollment.save
      redirect_to enrollments_path
    else
      render :new
    end
  end

  def show
    @enrollment = Params.find(params[:id])
  end

  def edit
    @enrollment = Params.find(params[:id])
  end

  def update
    @enrollment = Params.find(params[:id])
    if @enrollment.update_attributes(enrollment_params)
      redirect_to enrollments_path
    else
      render :edit
    end
  end

  def destroy
    @enrollment = Params.find(params[:id])
    @enrollment.destroy
    redirect_to enrollments_path
  end

private
  def enrollment_params
    params.require(:enrollment).permit(:start_date, :end_date, :course_id, :student_id)
  end
end

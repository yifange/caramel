class AttendencesController < ApplicationController
  def index
    @attendences = Attendence.all
  end

  def new
    @attendence = Attendence.new
  end

  def create
    @attendence = Attendence.new(attendence_params)
    if @attendence.save
      redirect_to attendences_path
    else
      render :new
    end
  end

  def show
    @attendence = Attendence.find(params[:id])
  end

  def edit
    @attendence = Attendence.find(params[:id])
  end

  def update
    @attendence = Attendence.find(params[:id])
    if @attendence.update_attributes(attendence_params)
      redirect_to attendences_path
    else
      render :edit
    end
  end

  def destroy
    @attendence = Attendence.find(params[:id])
    @attendence.destroy
    redirect_to attendences_path
  end

private
  def attendence_params
    params.require(:attendence).permit(:enrollment_id, :date, :attendence_marking_id)
  end
end

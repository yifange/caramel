class AttendenceMarkingsController < ApplicationController
  def index
    @attendence_markings = AttendenceMarking.all
  end

  def new
    @attendence_marking = AttendenceMarking.new
  end

  def create
    @attendence_marking = AttendenceMarking.new(attendence_marking_params)
    if @attendence_marking.save
      redirect_to attendence_markings_path
    else
      render :new
    end
  end

  def show
    @attendence_marking = AttendenceMarking.find(params[:id])
  end

  def edit
    @attendence_marking = AttendenceMarking.find(params[:id])
  end

  def update
    @attendence_marking = AttendenceMarking.find(params[:id])
    if @attendence_marking.update_attributes(attendence_marking_params)
      redirect_to attendence_markings_path
    else
      render :edit
    end
  end

  def destroy
    @attendence_marking = AttendenceMarking.find(params[:id])
    @attendence_marking.destroy
    redirect_to attendence_markings_path
  end

private
  def attendence_marking_params
    params.require(:attendence_marking).permit(:abbrev, :full)
  end
end

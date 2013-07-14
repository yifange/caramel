class CalendarMarkingsController < ApplicationController
  def index
    @calendar_markings = CalendarMarking.all
  end

  def new
    @calendar_marking = CalendarMarking.new
  end

  def create
    @calendar_marking = CalendarMarking.new(calendar_marking_params)
    if @calendar_marking.save
      redirect_to calendar_markings_path
    else
      render :new
    end
  end

  def show
    @calendar_marking = CalendarMarking.find(params[:id])
  end

  def edit
    @calendar_marking = CalendarMarking.find(params[:id])
  end

  def update
    @calendar_marking = CalendarMarking.find(params[:id])
    if @calendar_marking.update_attributes(calendar_marking_params)
      redirect_to calendar_markings_path
    else
      render :edit
    end
  end

  def destroy
    @calendar_marking = CalendarMarking.find(params[:id])
    @calendar_marking.destroy
    redirect_to calendar_markings_path
  end

private
  def calendar_marking_params
    params.require(:calendar_marking).permit(:abbrev, :full)
  end
end

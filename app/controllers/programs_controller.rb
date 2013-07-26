class ProgramsController < ApplicationController
  respond_to  :html, :json

  def get_teachers
    @teachers = Teacher.all
    @results = @teachers.map { |teacher| {:id => teacher.id, :text => teacher.first_name + " " + teacher.last_name}}
    render :json => @results
  end

  def save_teachers
    @values = params[:value].map { |v| v[:text]}
  end

  def index
    if current_user && current_user.type != "Admin"
      @schools = School.where(:region_id => current_user.region_id)
      # @teachers = Teacher.find(:all, :conditions => {:region_id => current_user.region_id})
      @teachers = Teacher.where(:region_id => current_user.region_id)
      @instruments = Instrument.all
      # @students = Student.find(:all, :conditions => {:region_id => current_user.region_id})
    else
      @schools = School.all
      @teachers = Teacher.all
      @instruments = Instrument.all
    end
    @programs = Program.all
  end

  def new
    @program = Program.new
  end

  def create
    # render :json => params
    @program = Program.new(program_params)
    if @program.save
      redirect_to programs_path
    else
      render :new
    end
  end

  def show
    @program = Program.find(params[:id])
  end

  def edit
    @program = Program.find(params[:id])
  end

  def update
    @program = Program.find(params[:id])
    if @program.update_attributes(program_params)
      redirect_to programs_path
    else
      render :edit
    end
  end

  def destroy
    @program = Program.find(params[:id])
    @program.destroy
    redirect_to programs_path
  end

private
  def program_params
    params.require(:program).permit(:school_id, :instrument_id, :course_type_id, :regular_courses_per_year, :group_courses_per_year)
  end
end

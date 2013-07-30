class ProgramsController < ApplicationController
  def index
    @program = Program.all.first
  end

  respond_to  :html, :json

	def regions

	end

  def get_instruments
    @instruments = Instrument.all
    @results = @instruments.map { |instrument| {:id => instrument.id, :text => instrument.name}}
    render :json => @results
  end

  def get_teachers
    @teachers = Teacher.all
    @results = @teachers.map { |teacher| {:id => teacher.id, :text => teacher.first_name + " " + teacher.last_name}}
    render :json => @results
  end

  def save_teachers
    @values = params[:value]
    @assignments = Assignment.where(:program_id => params[:pk])
    @assignments.each do |ass|
      @values.each do |v|
        if ass.teacher_id == v # assignment already exists
          @values.delete(v)
          @assignments.delete(ass)
        end
      end
    end

    @assignments.each do |ass| # assignment not found, deleted
      Assignment.delete(ass)
    end
    @values.each do |v| # assignment created
      Assignment.create(:program_id => params[:pk], :teacher_id => v)
    end
    render :json => params
  end

  def schools
    if current_user && current_user.type != "Admin"
      @schools = School.where(:region_id => current_user.region_id)
      @teachers = Teacher.where(:region_id => current_user.region_id)
      @instruments = Instrument.all
      # @teachers = Teacher.find(:all, :conditions => {:region_id => current_user.region_id})
      # @students = Student.find(:all, :conditions => {:region_id => current_user.region_id})
    else
      @schools = School.all
      @teachers = Teacher.all
      @instruments = Instrument.all
    end
    @programs = Program.all
  end

	def instrument_types

	end
  
  def new
    @program = Program.new
  end
  def create
    # render :json => params
    # @program = Program.new(program_params)
    # if @program.save
    #   redirect_to programs_path
    # else
    #   render :new
    # end
    @program = Program.new(program_params)
    if @program.save
      redirect_to programs_path
    else
      render :new
    end
  end

	def program_types

	end

private
  def program_params
    params.require(:program).permit(:school_id, :instrument_id, :course_type_id, :regular_courses_per_year, :group_courses_per_year)
  end
end

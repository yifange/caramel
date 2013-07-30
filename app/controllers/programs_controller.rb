class ProgramsController < ApplicationController
  respond_to  :html, :json

	def regions
		verify_user
	end

  def get_teachers
    @teachers = Teacher.all
    @results = @teachers.map { |teacher| {:id => teacher.id, :text => teacher.first_name + " " + teacher.last_name}}
    render :json => @results
  end

  def save_teachers
    @v = params[:value]
    @t = @v[:text]
  end

  def schools
		verify_user
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

	def instrument_types
		verify_user
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

	def program_types
		verify_user
	end
end

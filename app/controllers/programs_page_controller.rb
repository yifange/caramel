class ProgramsPageController < ApplicationController
  def index
    @program = Program.all.first
  end

  respond_to  :html, :json

	def regions
		verify_user
    @regions = RegionsController.index
	end

  def get_instruments
    @instruments = Instrument.all.order("name ASC")
    @results = @instruments.map { |instrument| {:id => instrument.id, :text => instrument.name}}
    render :json => @results
  end

  def save_instruments
    @program = Program.find(params[:pk])
    @program.update_attributes(:instrument_id => params[:value])
    render :text => "Save Instrument Successully!"
  end

  def get_teachers
    @teachers = Teacher.all
    @results = @teachers.map do |teacher|  
      {:id => teacher.id, :text => teacher.first_name + " " + teacher.last_name}
    end
    render :json => @results
  end

  def get_assigned_teachers
    programs = Program.all
    @assigned_teachers = {}
    programs.each do |program|
      assignments_for_program = Assignment.where(:program_id => program.id)
      assignments_str = assignments_for_program.map do |assignment| 
        teacher = Teacher.find(assignment.teacher_id)
        teacher.id.to_s + ":" + teacher.first_name + teacher.last_name
      end.join(",")
      @assigned_teachers[program.id] = assignments_str
    end
    return @assigned_teachers
  end
  
  def save_teachers
    @values = params[:value].split(',')
    puts params[:value]
    @assignments = Assignment.where(:program_id => params[:pk])
    @assignments.each do |assignment|
      @values.each do |val|
        v = val.to_i
        if assignment.teacher_id == v # assignment already exists
          @values.delete(val)
          @assignments.delete(assignment)
        end
      end
    end

    @assignments.each do |assignment| # assignment not found, deleted
      Assignment.delete(assignment)
    end
    @values.each do |val| # assignment created
      Assignment.create(:program_id => params[:pk], :teacher_id => val.to_i)
    end
    render :text => "Save Teachers Successfully!"
  end


  def schools
    if current_user && current_user.type != "Admin"
      dm = Domain.where(:user_id => current_user.id).first
      @schools = School.where(:region_id => dm.region_id)
      @teachers = Teacher.where("region_id = current_user.region_id'")
      @programs = Program.all
    elsif current_user && current_user.type == "Admin"
      @schools = School.all
      @teachers = Teacher.all
      @programs = Program.all
    end

    @assigned_teachers = get_assigned_teachers
    @instruments = Instrument.all
  end

	def instrument_types
		verify_user
		@instruments = Instrument.all
	end
  
  def new
    @program = Program.new
  end
  
  def create
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

private
  def program_params
    params.require(:program).permit(:school_id, :instrument_id, :course_type_id, :regular_courses_per_year, :group_courses_per_year)
  end
end

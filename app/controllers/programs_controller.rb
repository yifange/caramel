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

  def save_instruments
    @program = Program.find(params[:pk])
    # puts '1111111111111111111111111111111111111111111111111111111111111111111111111'
    # puts @program.to_s
    # puts @program.regular_courses_per_year
    @program.update_attributes(:instrument_id => params[:value])
    #   puts '0000000000000000000000000000000000000000000000000000000000000000000000000000000'
    #   puts params.to_s
    # end
    render :text => 'hahahah'
  end

  def get_teachers
    @teachers = Teacher.all
    @results = @teachers.map do |teacher|  
      {:id => teacher.id, :text => teacher.first_name + " " + teacher.last_name}
    end
    render :json => @results
  end

  def get_assigned_teachers
    @assignments = Assignment.where(:program_id => params[:pk])
    @assigned_teachers = ""
    @assignments.each do |ass|
      @teacher = Teacher.find(ass.teacher_id)
      @assigned_teachers += ass.teacher_id + ":"  + @teacher.first_name + " " + @teacher.last_name + ","
    end
  end

  def save_teachers
    @values = params[:value].split(',')
    @assignments = Assignment.where(:program_id => params[:pk])
    @assignments.each do |assignment|
      @values.each do |val|
        v = val.to_i
        if ass.teacher_id == v # assignment already exists
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

    render :text => 'hahahh'
  end

  def schools
    # if current_user && current_user.type != "Admin"
    #   @schools = School.where(:region_id => current_user.region_id)
    #   @teachers = Teacher.where(:region_id => current_user.region_id)
    #   @instruments = Instrument.all
    #   @assigned_teachers = get_assigned_teachers
    #   # @teachers = Teacher.find(:all, :conditions => {:region_id => current_user.region_id})
    #   # @students = Student.find(:all, :conditions => {:region_id => current_user.region_id})
    # else
    @schools = School.all
    @teachers = Teacher.all
    @instruments = Instrument.all
    # end
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

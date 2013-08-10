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

  def save_instrument
    @program = Program.find(params[:pk])
    @program.update_attributes(:instrument_id => params[:value])
    render :text => "Save Instrument Successully!"
  end

  def get_course_types
    @course_types = CourseType.all
    @results = @course_types.map { |course_type| {:id => course_type.id, :text => course_type.abbrev}}
    render :json => @results
  end

  def save_course_type
    @program = Program.find(params[:pk])
    @program.update_attributes(:course_type_id => params[:value])
    render :text => "Save Course Type Successully!"
  end

  def save_regular_courses
    @program = Program.find(params[:pk])
    @program.update_attributes(:regular_courses_per_year => params[:value])
    render :text => "Save Regular Courses Successully!"
  end

  def save_group_courses
    @program = Program.find(params[:pk])
    @program.update_attributes(:group_courses_per_year => params[:value])
    render :text => "Save Group Courses Successully!"
  end

  def get_teachers
    @teachers = Teacher.all
    @results = @teachers.map do |teacher|  
      {:id => teacher.id, :text => teacher.first_name + " " + teacher.last_name}
    end
    render :json => @results
  end

  def get_details
    programs = Program.all
    @assigned_teachers = {}
    @enrolled_students = {}
    programs.each do |program|
      assignments_for_program = Assignment.where(:program_id => program.id)
      enrollments_for_program = Enrollment.where(:program_id => program.id)
      assignments_str = assignments_for_program.map do |assignment| 
        teacher = Teacher.find(assignment.teacher_id)
        teacher.id.to_s + ":" + teacher.first_name + teacher.last_name
      end.join(",")
      enrollments_str = enrollments_for_program.map do |enrollment| 
        student = Student.find(enrollment.student_id)
        student.id.to_s + ":" + student.first_name + student.last_name
      end.join(",")
      @assigned_teachers[program.id] = assignments_str
      @enrolled_students[program.id] = enrollments_str
    end
    return [@assigned_teachers, @enrolled_students]
  end
  
  def save_teachers
# <<<<<<< HEAD
#     @values = params[:value].split(',')
#     puts params[:value]
#     @assignments = Assignment.where(:program_id => params[:pk])
#     @assignments.each do |assignment|
#       @values.each do |val|
#         v = val.to_i
#         if assignment.teacher_id == v # assignment already exists
#           @values.delete(val)
#           @assignments.delete(assignment)
#         end
#       end
# =======
    new_ids = params[:value].split(",").map(&:to_i)
    old_ids = Assignment.where(:program_id => params[:pk]).map {|a| a.teacher_id}
    (old_ids - new_ids).each do |id|
      Assignment.where(:program_id => params[:pk], :teacher_id => id).delete_all
    end
    (new_ids - old_ids).each do |id|
      Assignment.create(:program_id => params[:pk], :teacher_id => id)
# >>>>>>> origin/latte
    end
    render :text => "Save Teachers Successfully!"
  end

  
  def get_students
    @students = Student.all
    @results = @students.map do |student|  
      {:id => student.id, :text => student.first_name + " " + student.last_name}
    end
    render :json => @results
  end
  
  def save_students
    new_ids = params[:value].split(",").map(&:to_i)
    old_ids = Enrollment.where(:program_id => params[:pk]).map {|a| a.student_id}
    (old_ids - new_ids).each do |id|
      Enrollment.where(:program_id => params[:pk], :student_id => id).delete_all
    end
    (new_ids - old_ids).each do |id|
      Enrollment.create(:program_id => params[:pk], :student_id => id)
    end
    render :text => "Save Students Successfully!"
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

    @assigned_teachers = get_details[0]
    @enrolled_students = get_details[1]
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
      redirect_to programs_page_path
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

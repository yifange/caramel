class RostersController < ApplicationController
  before_filter :require_login
  def index
    @term_id = params[:term_id] || Term.order("start_date DESC").first.id
    
    @programs = case current_user[:type]
                when "Teacher"
                  # FIXME leave this in case we add the support for terms
                  Teacher.find(current_user[:id]).programs.order("school_id ASC").includes(:school, :instrument, :program_type)
                  # Teacher.find(current_user[:id]).programs.where(:term_id => @term_id).order("school_id ASC").includes(:school, :instrument, :program_type)
                when "Staff"
                  # FIXME leave this in case we add the support for terms
                  Staff.find(current_user[:id]).programs.order("school_id ASC").includes(:school, :instrument, :program_type)
                  # Staff.find(current_user[:id]).programs.where(:term_id => @term_id).order("school_id ASC").includes(:school, :instrument, :program_type)
                when "Admin"
                  # FIXME leave this in case we add the support for terms
                  Program.order("school_id ASC").includes(:school, :instrument, :program_type)
                  # Program.where(:term_id => @term_id).order("school_id ASC").includes(:school, :instrument, :program_type)
                end

    @program = (@programs.find_by :id => params[:program_id]) || @programs.first if @programs
    if @program
      @program_id = @program[:id]
      @courses = @program.courses.includes(:rosters => [:enrollment => [:student]]).order("name ASC")
      @students = @program.students.includes(:enrollments => [:rosters => [:course => [:students]]])
      @enrollments = @program.enrollments.includes(:student)
    end

  end
  
  def new
    course_type = params[:type]
    program_id = params[:program_id]
    student_id = params[:student_id]
    @enrollment_id = Enrollment.find_by(:program_id => program_id, :student_id => student_id).id
    if course_type == "group"
      @courses = Course.where(:program_id => program_id, :course_type => "GroupCourse")
    elsif course_type == "regular"
      @courses = Course.where(:program_id => program_id, :course_type => "RegularCourse")
    else
      @courses = Course.where(:program_id => program_id)
    end
    @roster = Roster.new
    render :layout => false
  end

  def add_student
    course_id = params[:course_id]
    @students = Program.find(params[:program_id]).students
    @roster = Roster.new
    @enrollments = Enrollment.where(:program_id => params[:program_id]).includes(:student)
    render :layout => false
  end
  def create
    roster = Roster.new(roster_params)
    if roster.save
      render :text => "success"
    else
      render :new
    end

  end
  def remove_student
    course_id = params[:course_id]
    enrollment_id = params[:enrollment_id]
    Roster.where(:course_id => course_id, :enrollment_id => enrollment_id).delete_all
    render :text => "student removed"
  end
  def edit
  end

  def update
    name = params[:name]
    value = params[:value]
    roster = Roster.find(params[:pk])
    if roster.update_attributes({name => value})
      render :text => "success"
    else
      render :text => roster.errors.messages[:base].first, :status => :unprocessable_entity
    end
  end
  private
  def roster_params
    params.require(:roster).permit(:course_id, :enrollment_id, :start_date, :end_date)
  end
end

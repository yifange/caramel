class RostersController < ApplicationController
  def index
    # XXX faked
    @term_id = params[:term_id] = 1

    if current_user[:type] == "Teacher"
      @teacher = Teacher.find(current_user[:id])
    end
    @programs = @teacher.programs.where(:term_id => @term_id).order("school_id ASC")
    @program = (@programs.find_by :id => params[:program_id]) || @programs.first if @programs
    if @program
      @program_id = @program[:id]
      @courses = @program.courses.includes(:students)
      @students = @program.students.includes(:courses)
    end


  end
end

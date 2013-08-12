class RostersController < ApplicationController
  def index
    @program_id = params[:program_id]  
    @term_id = params[:term_id]

    if current_user[:type] == "Teacher"
      @teacher = Teacher.find(current_user[:id])
    end
    @programs = @teacher.programs.where(:term_id => @term_id).order("school_id ASC")
  end
end

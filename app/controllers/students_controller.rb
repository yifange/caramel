class StudentsController < ApplicationController
 
  respond_to :html

  def index 
    @students = Student.all_ordered
  end

  def update 
    @student = Student.find(params[:pk])
    if params[:name] == 'user_name'
      @student.update_attributes(student_params)
    end
    render nothing: true
  end

  def student_params
    params.require(:value).permit(:first_name, :last_name)
  end

end

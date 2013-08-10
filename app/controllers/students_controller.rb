class StudentsController < ApplicationController
  def index
    @students = Student.all
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

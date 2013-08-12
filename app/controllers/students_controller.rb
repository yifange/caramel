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

  def new
    @student = Student.new
  end

  def create 
    @student = Student.new(student_params)
    if @student.save
      redirect_to :controller => "students", :actoin => "index"
    else
      render :new
    end
  end

private
  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end
end

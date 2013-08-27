class StudentsController < ApplicationController

  respond_to :html

  def index 
    verify_user(['Admin', 'Staff', 'Teacher'])
    @students = Student.all_ordered
  end

  def update 
    student = Student.find(params[:pk])
    if params[:name] == 'user_name'
      params[:student] = params[:value]
      student.update_attributes(student_params)
    elsif params[:name] == 'programs'
      if params[:option] == "add"
        student.add_program(params[:value])
      else
        student.remove_program(params[:value])
      end
    elsif params[:name] == 'school'
      params[:student] = {:school_id => params[:value_add]}
      student.update_attributes(student_params)
    end
    render nothing: true
  end

  def new
    @student = Student.new
  end

  def create 
    @student = Student.new(student_params)
    if @student.save
      redirect_to :controller => "students", :actoin => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def destroy_multi
    params[:deleteList].each do |item|
      student = Student.find(item)
      student.destroy
    end
    redirect_to :controller => "students", :action => "index"
  end

private
  def student_params
    params.require(:student).permit(:first_name, :last_name, :school_id)
  end

end

class StudentsController < ApplicationController

  respond_to :html

  def index 
    verify_user(['Admin', 'Staff', 'Teacher'])
    if current_user.type == 'Admin'
      @students = Student.all_ordered
    elsif current_user.type == 'Staff'
      @students = current_user.students_ordered
    elsif current_user.type == 'Teacher'
      @students = current_user.students_ordered
    end
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
    render json: {:id => params[:pk]}
  end

  def new
    @student = Student.new
  end

  def create 
    @student = Student.new(student_params)
    if @student.save
      flash_message :success, "#{@student.name}: Successfully added."
      redirect_to :controller => "students", :action => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def destroy_multi
    params[:deleteList].each do |item|
      begin
        student = Student.find(item)
        student.destroy
        flash_message :success, "#{student.name}: Successfully removed."
      rescue ActiveRecord::DeleteRestrictionError => e
        flash_message :error, "#{student.name}: Can not be removed, since there are programs assigned."
      end
    end
    redirect_to :controller => "students", :action => "index"
  end

  private
  def student_params
    params.require(:student).permit(:first_name, :last_name, :school_id)
  end

end

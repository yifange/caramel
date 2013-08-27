class TeachersController < ApplicationController

  respond_to :html

  def index 
    verify_user(['Admin', 'Staff'])
    if current_user.type == 'Admin'
      @teachers = Teacher.all_ordered
    elsif current_user.type == 'Staff'
      @teachers = current_user.teachers_ordered
    end
  end

  def update 
    teacher = Teacher.find(params[:pk])
    if params[:name] == 'email'
      params[:teacher] = {params[:name] => params[:value]}
      teacher.update_attributes(teacher_params)
    elsif params[:name] == 'regions'
      if params[:option] == "add"
        teacher.add_region(params[:value])
      else
        teacher.remove_region(params[:value])
      end
    elsif params[:name] == 'user_name'
      params[:teacher] = params[:value]
      teacher.update_attributes(teacher_params)
    end
    render nothing: true
  end

  def new
    @teacher = Teacher.new
  end

  def create 
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to :controller => "teachers", :actoin => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

private
  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

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
      elsif teacher.programs_in_one_region(params[:value]).length == 0
        teacher.remove_region(params[:value])
      end
    elsif params[:name] == 'programs'
      if params[:option] == "add"
        teacher.add_program(params[:value])
      else
        teacher.remove_program(params[:value])
      end
    elsif params[:name] == 'user_name'
      params[:teacher] = params[:value]
      teacher.update_attributes(teacher_params)
    end
    render json: {:id => params[:pk]}
  end

  def new
    @teacher = Teacher.new
  end

  def create 
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      flash_message :success, "#{@teacher.name}: Successfully added."
      redirect_to :controller => "teachers", :actoin => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def destroy_multi
    params[:deleteList].each do |item|
      begin
        teacher = Teacher.find(item)
        teacher.destroy
        flash_message :success, "#{teacher.name}: Successfully removed."
      rescue ActiveRecord::DeleteRestrictionError => e
        flash_message :error, "#{teacher.name}: Can not be removed, since there are programs assigned."
      end
    end
    redirect_to :controller => "teachers", :action => "index"
  end

private
  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

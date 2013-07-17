class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def show
    @teachers = Teacher.find(params[:id])
  end

  def new
    @teacher = Teacher.new
  end

  def create
    teacher = Teacher.new(teacher_params)
    if teacher.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def edit
    @techer = Teacher.find(params[:id])
  end

  def update
    @techer = Teacher.find(params[:id])
    if @teacher.update_attributes(teacher_params)
      redirect_to teachers
    else
      render :edit
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to teachers
  end

private
  def teacher_params
    params.require(:teacher).permit(:email, :password, :password_confirmation, :first_name, :middle_name, :last_name, :phone)
  end
end

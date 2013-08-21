class ProgramsController < ApplicationController
  respond_to  :html, :json

  def index
    @schools = School.all
  end

  def new
    @school_id = params[:entry_identity]
    @program = Program.new
  end

  def create
    @program = Program.new(program_params)
    if @program.save
      redirect_to :controller => "programs", :action => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
    @program = Program.find(params[:id])
  end

  def edit
    @program = Program.find(params[:id])
  end

  def update
    program = Program.find(params[:id])
    if params[:name] == 'number'
      params[:program] = params[:value]
      program.update_attributes(program_params)
    elsif params[:name] == 'program_type_id' || params[:name] == 'instrument_id'
      params[:program] = {params[:name] => params[:value_add]}
      program.update_attributes(program_params)
    elsif params[:name] == 'teachers'
      if params[:option] == "add"
        program.add_teacher(params[:value])
      else
        program.remove_teacher(params[:value])
      end
    elsif params[:name] == 'students'
      if params[:option] == "add"
        program.add_student(params[:value])
      else
        program.remove_student(params[:value])
      end
    end
    render nothing: true
  end

  def destroy
    @program = Program.find(params[:id])
    @program.destroy
    redirect_to :controller => "programs", :action => "index"
  end

  private
  def program_params
    params.require(:program).permit(:school_id, :instrument_id, :program_type_id, :regular_courses_per_year, :group_courses_per_year)
  end
end

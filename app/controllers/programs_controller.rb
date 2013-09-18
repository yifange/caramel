class ProgramsController < ApplicationController
  respond_to :html, :json

  def index
    verify_user(['Admin', 'Staff', 'Teacher'])
    if current_user.type == 'Admin'
      @regions = Region.all_ordered
    elsif current_user.type == 'Staff'
      @regions = current_user.regions_ordered
    elsif current_user.type == 'Teacher'
      @regions = current_user.regions_ordered
    end
  end

  def new
    @school_id = params[:school_id]
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

  def destroy_multi
    params[:deleteList].each do |item|
      begin
        program = Program.find(item)
        program.destroy
        flash_message :success, "#{program.name}: Successfully removed."
      rescue ActiveRecord::DeleteRestrictionError => e
        flash_message :error, "#{program.name}: Can not be removed, since there are students or teachers enrolled."
      end
    end
    redirect_to :controller => "programs", :action => "index"
  end

  private
  def program_params
    params.require(:program).permit(:school_id, :instrument_id, :program_type_id, :regular_courses_per_year, :group_courses_per_year)
  end

end

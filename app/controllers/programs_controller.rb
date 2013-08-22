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
    @program = Program.find(params[:id])
    if params[:name] == 'number'
      @program.update_attributes(program_params)
    else
      params[:value] = {params[:name] => params[:value]}
      @program.update_attributes(program_params)
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
      program = Program.find(item)
      program.destroy
    end
    redirect_to :controller => "programs", :action => "index"
  end

private
  def program_params
    params.require(:program).permit(:school_id, :instrument_id, :program_type_id, :regular_courses_per_year, :group_courses_per_year)
  end
end

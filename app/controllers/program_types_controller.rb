class ProgramTypesController < ApplicationController

  respond_to :html, :json

  def new
    @program_type = ProgramType.new
  end

  def create
    @program_type = ProgramType.new(program_type_params)
    if @program_type.save
      redirect_to :controller => "program_types", :action => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def update
    @program_type = ProgramType.find(params[:pk])
    params[:value] = {params[:name] => params[:value]}
    @program_type.update_attributes(program_type_params)
    render nothing: true
  end

  def index
    @program_types = ProgramType.all_ordered
    respond_with(ProgramType.all_ordered_json)
  end

private
  def program_type_params
    params.require(:program_type).permit(:name)
  end
end

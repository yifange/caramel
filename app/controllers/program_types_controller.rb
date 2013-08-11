class ProgramTypesController < ApplicationController

  respond_to :html

  def update
    @program_type = ProgramType.find(params[:pk])
    params[:value] = {params[:name] => params[:value]}
    @program_type.update_attributes(program_type_params)
    render nothing: true
  end

  def index
    @program_types = ProgramType.all_ordered
  end

  private
  def program_type_params
    params.require(:value).permit(:full, :abbrev)
  end

end

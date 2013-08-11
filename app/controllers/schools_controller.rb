class SchoolsController < ApplicationController

  respond_to :html

  def update
    @school = School.find(params[:pk])
    params[:value] = {params[:name] => params[:value]}
    @school.update_attributes(school_params)
    render nothing: true
  end

  def index
    @schools = School.all_ordered
  end

  private
  def school_params
    params.require(:value).permit(:region_id, :abbrev, :full)
  end

end

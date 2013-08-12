class RegionsController < ApplicationController

  respond_to :html, :json

  def update
    @region = Region.find(params[:pk])
    params[:value] = {params[:name] => params[:value]}
    @region.update_attributes(region_params)
    render nothing: true
  end

  def index
    if params[:teacher_id].present?
      respond_with(Teacher.find(params[:teacher_id]).regions_ordered_json)
    else
      @regions = Region.all_ordered
      respond_with(Region.all_ordered_json)
    end
  end

  private
  def region_params
    params.require(:value).permit(:name)
  end

end

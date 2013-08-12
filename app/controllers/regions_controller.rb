class RegionsController < ApplicationController

  respond_to :html, :json

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      redirect_to :controller => "regions", :action => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def update
    @region = Region.find(params[:pk])
    params[:value] = {params[:name] => params[:value]}
    @region.update_attributes(region_params)
    render nothing: true
  end

  def index
    @regions = Region.all_ordered
    respond_with(Region.all_ordered_json)
  end

  private
  def region_params
    params.require(:region).permit(:name)
  end

end

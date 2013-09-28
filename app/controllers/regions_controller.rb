class RegionsController < ApplicationController

  respond_to :html, :json

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)
    if @region.save
      flash_message :success, "#{@region.name}: Successfully added."
      redirect_to :controller => "regions", :action => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def update
    @region = Region.find(params[:pk])
    params[:region] = {params[:name] => params[:value]}
    @region.update_attributes(region_params)
    render nothing: true
  end

  def index
    @regions = current_user.regions
  end

  def destroy_multi
    params[:deleteList].each do |item|
      begin
        region = Region.find(item)
        region.destroy
        flash_message :success, "#{region.name}: Successfully removed."
      rescue ActiveRecord::DeleteRestrictionError => e
        flash_message :error, "#{region.name}: Can not be removed, since there are teachers or staffs enrolled or schools assigned."
      end
    end
    redirect_to :controller => "regions", :action => "index"
  end

private
  def region_params
    params.require(:region).permit(:name)
  end

end

class RegionsController < ApplicationController
  def update

  end

  def index
    @regions = Region.all.order("name ASC")
    @results = @regions.map { |region| {:id => region.id, :text => region.name}}
    render :json => @results
  end
end

class RegionsController < ApplicationController
  respond_to :html, :json
  def update

  end

  def index
    respond_with(Region.all_ordered_json)
  end
end

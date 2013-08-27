class SchoolsController < ApplicationController

  respond_to :html

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to :controller => "schools", :action => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def update
    school = School.find(params[:pk])
    if params[:name] == 'full' || params[:name] == 'abbrev'
      params[:school] = {params[:name] => params[:value]}
    elsif params[:name] == 'region'
      params[:school] = {:region_id => params[:value_add]}
    end
    school.update_attributes(school_params)
    render nothing: true
  end

  def index
    verify_user(['Admin', 'Staff'])
    if current_user.type == 'Admin'
      @schools = School.all_ordered
    elsif current_user.type == 'Staff'
      @schools = School.in_regions_ordered(current_user.region_ids)
    end
  end

private
  def school_params
    params.require(:school).permit(:region_id, :abbrev, :full)
  end

end

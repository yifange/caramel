class SchoolsController < ApplicationController

  respond_to :html

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      flash_message :success, "#{@school.name}: Successfully added."
      redirect_to :controller => "schools", :action => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def update
    school = School.find(params[:pk])
    if params[:name] == 'name' || params[:name] == 'abbrev'
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

  def destroy_multi
    params[:deleteList].each do |item|
      begin
        school = School.find(item)
        school.destroy
        flash_message :success, "#{school.name}: Successfully removed."
      rescue ActiveRecord::DeleteRestrictionError => e
        flash_message :error, "#{school.name}: Can not be removed, since there are students enrolled or programs assigned."
      end
    end
    redirect_to :controller => "schools", :action => "index"
  end

private
  def school_params
    params.require(:school).permit(:region_id, :abbrev, :name)
  end

end

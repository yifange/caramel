class SchoolsController < ApplicationController
  def index
    if current_user && current_user.type != "Admin"
      @schools = School.find(:all, :conditions => {:region_id => current_user.region_id})
    else
      @schools = School.all
    end
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to schools_path
    else
      render :new
    end
  end

  def destroy
    @school = School.find(params[:id])
    @school.destroy
    redirect_to schools_path
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])
    if @school.update_attributes(school_params)
      redirect_to schools_path
    else
      render :edit
    end
  end

  def show
    @school = School.find(params[:id])
  end

private
  def school_params
    params.require(:school).permit(:abbrev, :full, :region_id)
  end
end

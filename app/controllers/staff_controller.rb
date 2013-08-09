class StaffController < ApplicationController
  def index 
    @staff = Staff.all
    @staff_with_region = Staff.all_with_region_name
  end

  def show 

  end

  def create 

  end

  def update 
    @staff = Staff.find(params[:pk])
    if params[:name] == 'email'
      params[:value] = {params[:name] => params[:value]}
    end

    @staff.update_attributes(staff_params)
    render :text => ''
  end

  def destroy 

  end

  def remove

  end

  def staff_params
    params.require(:value).permit(:email, :first_name, :last_name, :middle_name)
  end
end

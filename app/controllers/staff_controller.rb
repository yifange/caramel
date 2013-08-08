class StaffController < ApplicationController
  def index 
    @staff = Staff.all
  end

  def show 

  end

  def create 

  end

  def update 
    @staff = Staff.find(params[:pk])
    if params[:name] == 'email'
      @staff.update_attribute(:email, params[:value])
    end
    render :text => ""
  end

  def destroy 

  end

  def remove

  end
end

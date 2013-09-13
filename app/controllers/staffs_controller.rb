class StaffsController < ApplicationController

  respond_to :html

  def index 
    verify_user(['Admin'])
    @staffs = Staff.all_ordered
  end

  def new
    @staff = Staff.new
    # @staff.domains.new
  end

  def create 
    @staff = Staff.new(staff_params)
    if @staff.save
      redirect_to :controller => "staffs", :actoin => "index"
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def update 
    staff = Staff.find(params[:pk])
    if params[:name] == 'email'
      params[:staff] = {params[:name] => params[:value]}
      staff.update_attributes(staff_params)
    elsif params[:name] == 'regions'
      if params[:option] == "add"
        staff.add_region(params[:value])
      else
        staff.remove_region(params[:value])
      end
    elsif params[:name] == 'user_name'
      params[:staff] = params[:value]
      staff.update_attributes(staff_params)
    end
    render nothing: true
  end

  def destroy 

  end

  def destroy_multi
    params[:deleteList].each do |item|
      staff = Staff.find(item)
      staff.destroy
    end
    redirect_to :controller => "staffs", :action => "index"
  end

private
  def staff_params
    params.require(:staff).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end

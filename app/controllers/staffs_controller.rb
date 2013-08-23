class StaffsController < ApplicationController

  respond_to :html

  def index 
    verify_user(['Admin'])
    @staffs = Staff.all_ordered
  end

  def new
    # @staff = Staff.new
    @staff = Staff.new
    # @staff.domains.new
  end

  def create 
    @staff = Staff.new(staff_params)
    # dmn = Domain.new(:region_id => params[:staff][:domains_attributes]["0"][:region_id], :user => @staff)
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
    elsif params[:name] == 'region'
      staff.change_region(params[:value_remove], params[:value_add])
    elsif params[:name] == 'user_name'
      params[:staff] = params[:value]
      staff.update_attributes(staff_params)
    end
    render nothing: true
  end

  def destroy 

  end

  def remove

  end

  private
  def staff_params
    params.require(:staff).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    # params.require(:staff).permit(:first_name, :last_name, :email, :password, :password_confirmation, :domains_attributes)
  end

end

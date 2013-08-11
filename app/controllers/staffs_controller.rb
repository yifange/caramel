class StaffsController < UsersController

  respond_to :html

  def index 
    @staffs = Staff.all_ordered
  end

  def update 
    @staff = Staff.find(params[:pk])
    if params[:name] == 'email'
      params[:value] = {params[:name] => params[:value]}
      @staff.update_attributes(user_params)
    elsif params[:name] == 'region'
      @staff.update_region(params[:value])
    elsif params[:name] == 'user_name'
      @staff.update_attributes(user_params)
    end
    render nothing: true
  end

end

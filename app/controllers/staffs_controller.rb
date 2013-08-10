class StaffsController < UsersController
  def index 
    @staffs = Staff.all
    @staffs_with_region = Staff.all_with_region_name
  end

  def show 

  end

  def create 

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

  def destroy 

  end

  def remove

  end

end

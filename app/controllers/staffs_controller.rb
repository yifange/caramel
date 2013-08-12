class StaffsController < UsersController
  def index 
    @staffs = Staff.all
    @staffs_with_region = Staff.all_with_region_name
  end

  def show 

  end

  def new
    # @staff = Staff.new
    @staff = Staff.new
    @staff.domains.new
  end

  def create 
    @staff = Staff.new(staff_params)
    @domain = Domain.new(:region_id => params[:staff][:domains_attributes]["0"][:region_id], :user => @staff)
    if @staff.save and @domain.save
      redirect_to :controller => "staffs", :actoin => "index"
    else
      render :new
    end
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

private
  def staff_params
    params.require(:staff).permit(:first_name, :last_name, :email, :password, :password_confirmation, :domains_attributes)
  end
end

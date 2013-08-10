class TeachersController < UsersController

  respond_to :html

  def index 
    @teachers = Teacher.all_ordered
  end

  def update 
    @teacher = Teacher.find(params[:pk])
    if params[:name] == 'email'
      params[:value] = {params[:name] => params[:value]}
      @teacher.update_attributes(user_params)
    elsif params[:name] == 'region'
      @teacher.update_region(params[:value])
    elsif params[:name] == 'user_name'
      @teacher.update_attributes(user_params)
    end
    render nothing: true
  end

end

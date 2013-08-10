class TeachersController < UsersController
  def index
    @teachers = Teacher.all
    @teachers_with_region = Teacher.all_with_region_name
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

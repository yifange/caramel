class StudentsController < PeoplesController
  def index
    @students = Student.all
  end

  def update 
    @student = Student.find(params[:pk])
    if params[:name] == 'user_name'
      @student.update_attributes(user_params)
    end
    render :text => ''
  end
end

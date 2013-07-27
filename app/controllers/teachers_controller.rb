class TeachersController < UsersController
  def index
    if current_user && current_user.type != "Admin"
      @teachers = Teacher.find(:all, :conditions => {:region_id => current_user.region_id})
    else
      @teachers = Teacher.all
    end
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      redirect_to teachers_path
    else
      render :new
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update_attributes(teacher_params)
      redirect_to teachers_path
    else
      render :edit
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    redirect_to teachers_path
  end

private
  def teacher_params
    params.require(:teacher).permit(:email, :password, :password_confirmation, :first_name, :middle_name, :last_name, :phone, :type, :region_id)
  end
end

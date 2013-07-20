class AdminsController < UsersController
#   def index
#   end
# 
#   def new
#     @admin = Admin.new
#   end
# 
#   def create
#     @admin = Admin.new(admin_params)
#     if @admin.save
#       redirect_to admins_path
#     else
#       render :new
#     end
#   end
# 
#   def edit
#     @admin = Admin.find(params[:id])
#   end
# 
#   def update
#     @admin = Admin.find(params[:id])
#     if @admin.update_attributes(admin_params)
#       redirect_to admins_path
#     else
#       render :edit
#     end
#   end
# 
#   def show
#     @admin = Admin.find(params[:id])
#   end
# 
#   def destroy
#     @admin = Admin.find(params[:id])
#     @admin.destroy
#     redirect_to admins_path
#   end
# 
# private
#   def admin_params
#     params.require(:admin).permit(:email, :password, :password_confirmation, :first_name, :middle_name, :last_name, :phone)
#   end
end

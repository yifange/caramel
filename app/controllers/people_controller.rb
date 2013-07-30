# People page
class PeopleController < ApplicationController
  def staff
		verify_user
        # @staffs=Staff.pluck(:first_name, :last_name, :email, :Region)
        @staffs = Staff.all
	end

  def teachers
		verify_user
  end

  def students
		verify_user
  end

  def get_firstname(last_name)
         Staff.where(:last_name).first_name
  end

end

# People page
class PeopleController < ApplicationController
  def staff
		verify_user
        @staffs = Staff.all
	end

  def teachers
		verify_user
		@teachers = Teacher.all
  end

  def students
		verify_user
		@students = Student.all
  end
  
end

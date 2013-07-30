# People page
class PeopleController < ApplicationController
  def staff
		verify_user
	end

  def teachers
		verify_user
  end

  def students
		verify_user
  end
end

class PeoplePageController < ApplicationController
  def staff
		verify_user
    @staff_with_region = Staff.all_with_region_name
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

  def get_regions
    @regions = Region.all
    @results = @regions.map do |region|
      {:id => region.id, :text => region.name}
    end
    render :json => @results
  end

end

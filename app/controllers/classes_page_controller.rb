class ClassesPageController < ApplicationController
  def calendar
		verify_user
  end

  def schedule
		verify_user
  end

  def attendance
		verify_user
  end
end

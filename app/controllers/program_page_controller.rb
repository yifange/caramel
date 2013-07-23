class ProgramPageController < ApplicationController
  def index
		@test = 1

		@school = School.all	
		#@test2 = @school.first.abbrev
  end
end

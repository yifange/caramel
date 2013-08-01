class Course < ActiveRecord::Base
  belongs_to :program
  def group
    type == "GroupCourse"
  end
end

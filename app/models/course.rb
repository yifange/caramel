class Course < ActiveRecord::Base
  belongs_to :program
  def start_date
    program.start_date
  end
  def end_date
    program.end_date
  end
  # def recurring?
  #   type == "GroupCourse"
  # end
  def group
    type == "GroupCourse"
  end
end

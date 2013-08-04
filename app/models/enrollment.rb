class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :program
  def rosters
    courses_of_program = program.courses
    rosters_of_enrollment = []
    for course in courses_of_program
      item = Roster.where(:student_id => student.id, :course_id => course.id)
      # XXX date range??
      rosters_of_enrollment += item
    end
    rosters_of_enrollment
  end
end

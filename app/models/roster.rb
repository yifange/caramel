class Roster < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
  belongs_to :enrollment
  has_many :attendances
  before_save :set_enrollment
  def course_name
    course.name
  end
  def course_type
    course.course_type
  end
  def start_time
    course.start_time
  end
  def end_time
    course.end_time
  end
  def date
    course.date
  end
  def day_of_week
    course.day_of_week
  end
  private

  def set_enrollment
    if course
      program_id = course.program.id
      self.enrollment_id = Enrollment.where(:program_id => program_id, :student_id => student_id).first.id
    end
  end
end

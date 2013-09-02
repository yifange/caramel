class Roster < ActiveRecord::Base
  # belongs_to :student
  belongs_to :course
  belongs_to :enrollment
  has_many :attendances
  validate :start_date_must_in_term, :end_date_must_in_term, :start_date_must_before_end_date
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
  def start_date_must_in_term
    term = course.program.term 
    unless start_date.nil? or (term.start_date <= start_date and start_date <= term.end_date)
      errors.add(:base, "not in term") 
    end
  end
  def end_date_must_in_term
    term = course.program.term
    unless end_date.nil? or (term.start_date <= end_date and end_date <= term.end_date)
      errors.add(:base, "not in term")
    end
  end
  def start_date_must_before_end_date
    unless start_date.nil? or end_date.nil? or start_date <= end_date
      errors.add(:base, "start date must before end date")
    end
  end
end

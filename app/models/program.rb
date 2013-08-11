class Program < ActiveRecord::Base
  belongs_to :school
  belongs_to :instrument
  belongs_to :program_type
  belongs_to :term
  belongs_to :instrument
  belongs_to :program_type
  has_many :enrollments
  has_many :assignments
  has_many :teachers, :through => :assignments
  has_many :students, :through => :enrollments
  has_many :courses

  def start_date
    term.start_date
  end
  def end_date
    term.end_date
  def regular_group_course
    "#{regular_courses_per_year}" + " / " + "#{group_courses_per_year}"
  end
end

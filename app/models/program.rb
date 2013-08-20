class Program < ActiveRecord::Base

  belongs_to :school
  belongs_to :instrument
  belongs_to :program_type
  belongs_to :term
  has_many :enrollments
  has_many :assignments
  has_many :teachers, :through => :assignments
  has_many :students, :through => :enrollments
  has_many :courses

  validates_presence_of :school
  validates_presence_of :instrument
  validates_presence_of :program_type

  def start_date
    term.start_date
  end

  def end_date
    term.end_date
  end

  def regular_group_course
    "#{regular_courses_per_year}" + " / " + "#{group_courses_per_year}"
  end

  def name
    "#{instrument.name}" + "-" + "#{program_type.name}"
  end

  def teacher_ids
    result = []
    teachers.each do |teacher|
      result.push(teacher.id)
    end
    result
  end

  def student_ids
    result = []
    students.each do |student|
      result.push(student.id)
    end
    result
  end

end

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
    teachers.map do |teacher|
      teacher.id
    end
  end

  def teacher_names
    result = ''
    teachers.map do |teacher|
      result += teacher.name
      result += ', '
    end
    result.chop.chop
  end

  def student_ids
    students.map do |student|
      student.id
    end
  end

  def add_teacher(teacher_id)
    Assignment.create(teacher_id: teacher_id, program_id: id)
  end

  def remove_teacher(teacher_id)
    Assignment.destroy(Assignment.where(:teacher_id => teacher_id, :program_id => id))
  end

  def add_student(student_id)
    Enrollment.create(student_id: student_id, program_id: id)
  end

  def remove_student(student_id)
    Enrollment.destroy(Enrollment.where(:student_id => student_id, :program_id => id))
  end 

end

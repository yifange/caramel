class Program < ActiveRecord::Base

  belongs_to :school
  belongs_to :instrument
  belongs_to :program_type
  belongs_to :term
  has_many :courses
  has_many :enrollments, :dependent => :restrict_with_exception
  has_many :assignments, :dependent => :restrict_with_exception
  has_many :teachers, :through => :assignments
  has_many :students, :through => :enrollments

  validates_presence_of :school
  validates_presence_of :instrument
  validates_presence_of :program_type
  validates_presence_of :regular_courses_per_year
  validates_presence_of :group_courses_per_year
  validates_uniqueness_of :instrument_id, :scope => [:school_id, :program_type_id]

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
    "#{instrument.name}" + " - " + "#{program_type.name}"
  end

  def name_with_school
    "#{school.name}" + " - " + "#{instrument.name}" + " - " + "#{program_type.name}"
  end

  def teacher_ids
    teachers.map do |teacher|
      teacher.id
    end
  end

  def student_ids
    students.map do |student|
      student.id
    end
  end

  def add_teacher(teacher_id)
    assignments.create(:teacher_id => teacher_id)
  end

  def remove_teacher(teacher_id)
    assignments.where(:teacher_id => teacher_id).destroy_all
  end

  def add_student(student_id)
    enrollments.create(:student_id => student_id)
  end

  def remove_student(student_id)
    enrollments.where(:student_id => student_id).destroy_all
  end 

end

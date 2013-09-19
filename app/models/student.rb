class Student < ActiveRecord::Base

  include People

  belongs_to :school
  has_many :enrollments
  has_many :rosters
  has_many :programs, :through => :enrollments, :dependent => :restrict_with_exception
  has_many :courses, :through => :rosters

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :school_id

  def self.all_ordered
    users = Student.all.order("first_name")
  end

  def self.in_regions_ordered(region_ids)
    students = []
    region_ids.each do |region_id|
      Region.find(region_id).schools.each do |school|
        students += school.students
      end
    end
    students.uniq.sort_by{|student| student.first_name}
  end

  def self.in_programs(program_ids)
    students = []
    program_ids.each do |program_id|
      students += Program.find(program_id).students
    end
    students.uniq
  end

  def program_ids
    programs.map do |program|
      program.id
    end
  end

  def add_program(program_id)
    Enrollment.create(student_id: id, program_id: program_id)
  end

  def remove_program(program_id)
    Enrollment.destroy(Enrollment.where(:student_id => id, :program_id => program_id))
  end

  def school_locked
    programs.any?
  end

  def get_students_by_school_id_and_teacher_id(school_id, teacher_id)
    Student.joins(:programs => [:school, :teachers]).where(:programs => {:school_id => school_id}, :assignments => {:teacher_id => teacher_id})
  end

end 

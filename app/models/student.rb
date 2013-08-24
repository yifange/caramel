class Student < ActiveRecord::Base

  belongs_to :school
  has_many :enrollments
  has_many :rosters
  has_many :programs, :through => :enrollments
  has_many :courses, :through => :rosters

  validates_presence_of :first_name
  validates_presence_of :last_name

  include People

  def self.all_ordered
    users = Student.all.order("first_name")
  end

  def self.in_one_region_ordered(region_id)
    students = []
    Region.find(region_id).schools.each do |school|
      students += school.students
    end
    students
  end

  def self.in_programs_ordered(program_ids)
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

end

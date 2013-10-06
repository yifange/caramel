class Student < ActiveRecord::Base

  include People

  belongs_to :school
  has_many :enrollments
  has_many :rosters, :through => :enrollments
  has_many :programs, :through => :enrollments, :dependent => :restrict_with_exception
  has_many :courses, :through => :rosters

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :school_id

  def self.all_ordered
    users = Student.all.order("first_name")
  end
  def current_rosters
    rosters.where("start_date <= :current_date AND end_date >= :current_date", current_date: Time.now)
  end
  def current_courses
    courses.joins(:rosters).uniq.where("rosters.start_date <= :current_date AND rosters.end_date >= :current_date", current_date: Time.now)
  end
  def all_current_course_names
    res = ""
    current_courses.each do |course|
      res += course.name
      res += ", "
    end
    res.chop.chop
  end
  def current_courses_with_teacher(teacher_id)
    current_courses.joins(:teachers).where(:users => {:id => teacher_id})
  end
  def all_current_course_with_teacher_names(teacher_id)
    res = ""
    current_courses_with_teacher(teacher_id).each do |course|
      res += course.name
      res += ", "
    end
    res.chop.chop
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

  def programs_with_teacher(teacher_id)
    programs.joins(:assignments).where(:assignments => {:teacher_id => teacher_id})
  end

  def programs_with_teacher_ids(teacher_id)
    programs_with_teacher(teacher_id).map do |program|
      program.id
    end
  end

end 

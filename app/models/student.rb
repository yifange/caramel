class Student < ActiveRecord::Base
  has_many :enrollments
  has_many :programs, :through => :enrollments
  has_many :courses, :through => :rosters
  has_many :rosters
  belongs_to :school
  include People


  def self.all_ordered
    users = Student.all.order("first_name")
  end

  def get_students_by_school_id_and_teacher_id(school_id, teacher_id)
    Student.joins(:programs => [:school, :teachers]).where(:programs => {:school_id => school_id}, :assignments => {:teacher_id => teacher_id}
  end

end

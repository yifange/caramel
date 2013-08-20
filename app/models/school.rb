class School < ActiveRecord::Base

  belongs_to :region
  has_many :students
  has_many :programs
  validates_presence_of :abbrev, :full, :region
  validates :abbrev, :uniqueness => {:scope => :full}

  def self.all_ordered_json
    schools = School.all.order("full")
    schools.map do |school| 
      {:id => school.id, :text => school.full}
    end
  end

  def teachers
    teachers = []
    programs.includes(:assignments, :teachers).each do |program|
      teachers += program.teachers
    end
    teachers.uniq
  end

  def program_all_ordered_json
    programs.map do |program|
      {:id => program.id, :text => program.name}
    end
  end

  def self.all_ordered
    School.all.order("full")
  end

  def students_ordered_json
    students.map do |student|
      {:id => student.id, :text => student.name}
    end
  end

  def teachers_ordered_json
    teachers.map do |teacher|
      {:id => teacher.id, :text => teacher.name}
    end
  end

end

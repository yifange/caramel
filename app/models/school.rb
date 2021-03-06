class School < ActiveRecord::Base

  belongs_to :region
  has_many :students, :dependent => :restrict_with_exception
  has_many :programs, :dependent => :restrict_with_exception
  has_many :teachers, -> {uniq}, :through => :programs
  validates_presence_of :abbrev, :name, :region
  validates :abbrev, :uniqueness => {:scope => :name}

  def self.all_ordered
    all.order("name")
  end

  def self.all_ordered_json
    all_ordered.map do |school| 
      {:id => school.id, :text => school.name}
    end
  end

  def self.in_regions_ordered(region_ids)
    schools = []
    region_ids.each do |region_id|
      schools += Region.find(region_id).schools
    end
    schools.uniq.sort_by{|school| school.name}
  end

  def self.in_regions_ordered_json(region_ids)
    in_regions_ordered(region_ids).map do |school| 
      {:id => school.id, :text => school.name}
    end
  end

  def programs_json
    programs.map do |program|
      {:id => program.id, :text => program.name}
    end
  end

  def students_ordered_json
    students.order("first_name").map do |student|
      {:id => student.id, :text => student.name}
    end
  end

  def students_unenrolled
    result = []
    students.each do |student|
      result.push(student)
    end
    Student.where(:school_id => id).joins(:programs).uniq.each do |student|
      result.delete(student)
    end
    result
  end

  def region_locked
    students.any? || teachers.any?
  end

end

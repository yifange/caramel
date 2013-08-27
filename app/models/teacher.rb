class Teacher < User

  authenticates_with_sorcery!

  has_many :assignments
  has_many :programs, :through => :assignments
  has_many :schools, :through => :programs

  def program_ids
    programs.map do |program|
      program.id
    end
  end

  def self.in_regions_ordered(region_ids)
    User.in_regions_ordered('Teacher', region_ids)
  end

  def self.all_ordered
    User.all_ordered('Teacher')
  end

  def schools_ordered
    schools = []
    programs.each do |program|
      schools.push(School.find(program.school_id))
    end
    schools.uniq.sort_by{|school| school.full}
  end

  def schools_ordered_json
    schools_ordered.map do |school|
      {:id => school.id, :text => school.full}
    end
  end

  def students_ordered
    students = Student.in_programs(program_ids)
    schools_ordered.each do |school|
      students += school.students_unenrolled
    end
    students.sort_by {|student| student.first_name}
  end

  def students_ordered_json
    students_ordered.map do |student|
      {:id => student.id, :text => student.name}
    end
  end

end

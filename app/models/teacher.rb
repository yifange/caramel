class Teacher < User
  has_many :assignments
  has_many :programs, :through => :assignments
  has_many :schools, :through => :programs
  authenticates_with_sorcery!

  def self.all_ordered
    User.all_ordered('Teacher')
  end

  def self.in_one_region_ordered(region_id)
    Region.find(region_id).users.where(:type => 'Teacher')
  end

  def schools
    schools = []
    programs.each do |program|
      schools.push(School.find(program.school_id))
    end
    schools
  end

  def schools_json
    schools.map do |school|
      {:id => school.id, :text => school.full}
    end
  end

end

class Staff < User

  authenticates_with_sorcery!

  def self.in_regions_ordered(region_ids)
    User.in_regions_ordered('Staff', region_ids)
  end

  def self.all_ordered
    User.all_ordered('Staff')
  end

  def schools_ordered
    School.in_regions_ordered(region_ids)
  end

  def schools_ordered_json
    schools_ordered.map do |school|
      {:id => school.id, :text => school.name}
    end
  end

  def teachers_ordered
    Teacher.in_regions_ordered(region_ids)
  end

  def students_ordered
    Student.in_regions_ordered(region_ids)
  end

end

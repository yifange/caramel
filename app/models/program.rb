class Program < ActiveRecord::Base
  belongs_to :school
  belongs_to :instrument
  belongs_to :program_type
  has_many :students, :through => :enrollments
  has_many :teachers, :through => :assignments
  has_many :courses

  def regular_group_course
    "#{regular_courses_per_year}" + " / " + "#{group_courses_per_year}"
  end
end

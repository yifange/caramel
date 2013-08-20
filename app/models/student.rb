class Student < ActiveRecord::Base
  has_many :enrollments
  has_many :programs, :through => :enrollments
  has_many :courses, :through => :rosters
  has_many :rosters
  include People


  def self.all_ordered
    users = Student.all.order("first_name")
  end

end

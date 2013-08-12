class Student < ActiveRecord::Base
  has_many :enrollments
  has_many :progams, :through => :enrollments

  include People

  def self.all_ordered
    users = Student.all.order("first_name")
  end

end

class Student < ActiveRecord::Base
  has_many :enrollments
  has_many :rosters
  has_many :progams, :through => :enrollments
  has_many :courses, :through => :rosters

  validates_presence_of :first_name
  validates_presence_of :last_name

  include People

  def self.all_ordered
    users = Student.all.order("first_name")
  end

end

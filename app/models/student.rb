class Student < ActiveRecord::Base
  has_many :enrollments
  has_many :progams, :through => :enrollments
end

class Program < ActiveRecord::Base
  belongs_to :school
  belongs_to :instrument
  belongs_to :course_type
  # has_many :users, :through => :registrations
  has_many :students, :through => :enrollments
  has_many :teachers, :through => :assignments
  has_many :courses
end

class Program < ActiveRecord::Base
  belongs_to :school
  belongs_to :instrument
  belongs_to :program_type
  belongs_to :term
  has_many :enrollments
  has_many :assignments
  has_many :teachers, :through => :assignments
  has_many :students, :through => :enrollments
  has_many :courses
end
